import 'dart:typed_data';
import 'dart:convert';
import 'dart:math';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:pointycastle/src/utils.dart';
import 'package:pointycastle/ecc/api.dart' show ECSignature, ECPoint;

import './exception.dart';
import './key_base.dart';
import './signature.dart';

///  Steem Public Key
class SteemPublicKey extends SteemKey {
  ECPoint? q;

  /// Construct  public key from buffer
  SteemPublicKey.fromPoint(this.q);

  /// Construct  public key from string
  factory SteemPublicKey.fromString(String keyStr) {
    var publicRegex = RegExp(r'^PUB_([A-Za-z0-9]+)_([A-Za-z0-9]+)',
        caseSensitive: true, multiLine: false);
    Iterable<Match> match = publicRegex.allMatches(keyStr);

    if (match.isEmpty) {
      var Regex = RegExp(r'^', caseSensitive: true, multiLine: false);
      if (!Regex.hasMatch(keyStr)) {
        throw InvalidKey('No leading ');
      }
      var publicKeyStr = keyStr.substring(3);
      var buffer = SteemKey.decodeKey(publicKeyStr);
      return SteemPublicKey.fromBuffer(buffer);
    } else if (match.length == 1) {
      var m = match.first;
      var keyType = m.group(1);
      var buffer = SteemKey.decodeKey(m.group(2)!, keyType);
      return SteemPublicKey.fromBuffer(buffer);
    } else {
      throw InvalidKey('Invalid public key format');
    }
  }

  factory SteemPublicKey.fromBuffer(Uint8List buffer) {
    var point = SteemKey.secp256k1.curve.decodePoint(buffer);
    return SteemPublicKey.fromPoint(point);
  }

  Uint8List toBuffer() {
    // always compressed
    return q!.getEncoded(true);
  }

  @override
  String toString([String address_prefix = 'STM']) {
    return toPublicKeyString(address_prefix);
  }

  String toPublicKeyString([String address_prefix = 'STM']) {
    return address_prefix + SteemKey.encodeKey(toBuffer(), keyType);
  }
}

///  Steem Private Key
class SteemPrivateKey extends SteemKey {
  Uint8List? d;
  String? format;

  late BigInt _r;
  late BigInt _s;

  /// Constructor  private key from the key buffer itself
  SteemPrivateKey.fromBuffer(this.d);

  /// Construct the private key from string
  /// It can come from WIF format for PVT format
  SteemPrivateKey.fromString(String keyStr) {
    var privateRegex = RegExp(r'^PVT_([A-Za-z0-9]+)_([A-Za-z0-9]+)',
        caseSensitive: true, multiLine: false);
    Iterable<Match> match = privateRegex.allMatches(keyStr);

    if (match.isEmpty) {
      format = 'WIF';
      keyType = 'K1';
      // WIF
      var keyWLeadingVersion = SteemKey.decodeKey(keyStr, SteemKey.SHA256X2);
      var version = keyWLeadingVersion.first;
      if (SteemKey.VERSION != version) {
        throw InvalidKey('version mismatch');
      }

      d = keyWLeadingVersion.sublist(1, keyWLeadingVersion.length);
      if (d!.lengthInBytes == 33 && d!.elementAt(32) == 1) {
        // remove compression flag
        d = d!.sublist(0, 32);
      }

      if (d!.lengthInBytes != 32) {
        throw InvalidKey('Expecting 32 bytes, got ${d!.length}');
      }
    } else if (match.length == 1) {
      format = 'PVT';
      var m = match.first;
      keyType = m.group(1);
      d = SteemKey.decodeKey(m.group(2)!, keyType);
    } else {
      throw InvalidKey('Invalid Private Key format');
    }
  }

  factory SteemPrivateKey.fromHex(String hexString) {
    return SteemPrivateKey.fromBuffer(
        Uint8List.fromList(hex.decode(hexString)));
  }

  String toHex() {
    return hex.encode(d!);
  }

  /// Generate  private key from seed. Please note: This is not random!
  /// For the given seed, the generated key would always be the same
  factory SteemPrivateKey.fromSeed(String seed) {
    var s = sha256.convert(utf8.encode(seed));
    return SteemPrivateKey.fromBuffer(s.bytes as Uint8List?);
  }

  /// Generate the random  private key
  factory SteemPrivateKey.fromRandom() {
//    final int randomLimit = 1 << 32;
    final randomLimit = 4294967296;
    Random randomGenerator;
    try {
      randomGenerator = Random.secure();
    } catch (e) {
      randomGenerator = Random();
    }

    var randomInt1 = randomGenerator.nextInt(randomLimit);
    var entropy1 = encodeBigInt(BigInt.from(randomInt1));

    var randomInt2 = randomGenerator.nextInt(randomLimit);
    var entropy2 = encodeBigInt(BigInt.from(randomInt2));

    var randomInt3 = randomGenerator.nextInt(randomLimit);
    var entropy3 = encodeBigInt(BigInt.from(randomInt3));

    var entropy = entropy1.toList();
    entropy.addAll(entropy2);
    entropy.addAll(entropy3);
    var randomKey = Uint8List.fromList(entropy);
    var d = sha256.convert(randomKey);
    return SteemPrivateKey.fromBuffer(d.bytes as Uint8List?);
  }

  /// Check if the private key is WIF format
  bool isWIF() => format == 'WIF';

  /// Get the public key string from this private key
  SteemPublicKey toPublicKey() {
    var privateKeyNum = decodeBigInt(d!);
    var ecPoint = SteemKey.secp256k1.G * privateKeyNum;

    return SteemPublicKey.fromPoint(ecPoint);
  }

  /// Sign the bytes data using the private key
  SteemSignature sign(Uint8List data) {
    var d = sha256.convert(data);
    return signHash(d.bytes as Uint8List);
  }

  /// Sign the string data using the private key
  SteemSignature signString(String data) {
    return sign(utf8.encode(data) as Uint8List);
  }

  /// Sign the SHA256 hashed data using the private key
  SteemSignature signHash(Uint8List sha256Data) {
    if (sha256Data.lengthInBytes != 32 || sha256Data.isEmpty) {
      throw ('buf_sha256: 32 byte buffer requred');
    }
    var nonce = 0;
    var n = SteemKey.secp256k1.n;
    var e = decodeBigInt(sha256Data);

    while (true) {
      _deterministicGenerateK(sha256Data, d!, e, nonce++);
      var N_OVER_TWO = n >> 1;
      if (_s.compareTo(N_OVER_TWO) > 0) {
        _s = n - _s;
      }
      var sig = ECSignature(_r, _s);

      var der = SteemSignature.ecSigToDER(sig);

      var lenR = der.elementAt(3);
      var lenS = der.elementAt(5 + lenR);
      if (lenR == 32 && lenS == 32) {
        var i = SteemSignature.calcPubKeyRecoveryParam(
            decodeBigInt(sha256Data), sig, toPublicKey());
        i += 4; // compressed
        i += 27; // compact  //  24 or 27 :( forcing odd-y 2nd key candidate)
        return SteemSignature(i, sig.r, sig.s);
      }
      if (nonce % 10 == 0) {
        print('WARN: $nonce attempts to find canonical signature');
      }
    }
  }

  @override
  String toString() {
    var version = <int>[];
    version.add(SteemKey.VERSION);
    var keyWLeadingVersion = SteemKey.concat(Uint8List.fromList(version), d!);

    return SteemKey.encodeKey(keyWLeadingVersion, SteemKey.SHA256X2);
  }

  // https://tools.ietf.org/html/rfc6979#section-3.2
  BigInt _deterministicGenerateK(
      Uint8List hash, Uint8List x, BigInt e, int nonce) {
    List<int> newHash = hash;
    if (nonce > 0) {
      List<int> addition = Uint8List(nonce);
      var data = List<int>.from(hash)..addAll(addition);
      newHash = sha256.convert(data).bytes;
    }

    // Step B
    var v = Uint8List(32);
    for (var i = 0; i < v.lengthInBytes; i++) {
      v[i] = 1;
    }

    // Step C
    var k = Uint8List(32);

    // Step D
    var d1 = List<int>.from(v)
      ..add(0)
      ..addAll(x)
      ..addAll(newHash);

    var hMacSha256 = Hmac(sha256, k); // HMAC-SHA256
    k = hMacSha256.convert(d1).bytes as Uint8List;

    // Step E
    hMacSha256 = Hmac(sha256, k); // HMAC-SHA256
    v = hMacSha256.convert(v).bytes as Uint8List;

    // Step F
    var d2 = List<int>.from(v)
      ..add(1)
      ..addAll(x)
      ..addAll(newHash);

    k = hMacSha256.convert(d2).bytes as Uint8List;

    // Step G
    hMacSha256 = Hmac(sha256, k); // HMAC-SHA256
    v = hMacSha256.convert(v).bytes as Uint8List;
    // Step H1/H2a, again, ignored as tlen === qlen (256 bit)
    // Step H2b again
    v = hMacSha256.convert(v).bytes as Uint8List;

    var T = decodeBigInt(v);
    // Step H3, repeat until T is within the interval [1, n - 1]
    while (T.sign <= 0 ||
        T.compareTo(SteemKey.secp256k1.n) >= 0 ||
        !_checkSig(e, newHash as Uint8List, T)) {
      var d3 = List<int>.from(v)..add(0);
      k = hMacSha256.convert(d3).bytes as Uint8List;
      hMacSha256 = Hmac(sha256, k); // HMAC-SHA256
      v = hMacSha256.convert(v).bytes as Uint8List;
      // Step H1/H2a, again, ignored as tlen === qlen (256 bit)
      // Step H2b again
      v = hMacSha256.convert(v).bytes as Uint8List;

      T = decodeBigInt(v);
    }
    return T;
  }

  bool _checkSig(BigInt e, Uint8List hash, BigInt k) {
    var n = SteemKey.secp256k1.n;
    var Q = (SteemKey.secp256k1.G * k)!;

    if (Q.isInfinity) {
      return false;
    }

    _r = Q.x!.toBigInteger()! % n;
    if (_r.sign == 0) {
      return false;
    }

    _s = k.modInverse(n) * (e + decodeBigInt(d!) * _r) % n;
    if (_s.sign == 0) {
      return false;
    }

    return true;
  }
}
