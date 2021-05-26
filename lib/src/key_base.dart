import 'dart:typed_data';
import 'dart:convert';

import 'package:bs58check/bs58check.dart';
import 'package:crypto/crypto.dart';
import 'package:pointycastle/digests/ripemd160.dart';
import 'package:pointycastle/src/utils.dart';
import 'package:pointycastle/ecc/curves/secp256k1.dart';

import './exception.dart';

/// abstract SteemKey
abstract class SteemKey {
  static final String SHA256X2 = 'sha256x2';
  static final int VERSION = 0x80;
  static final ECCurve_secp256k1 secp256k1 = ECCurve_secp256k1();

  String? keyType;

  /// Decode key from string format
  static Uint8List decodeKey(String keyStr, [String? keyType]) {
    var buffer = base58.decode(keyStr);

    var checksum = buffer.sublist(buffer.length - 4, buffer.length);
    var key = buffer.sublist(0, buffer.length - 4);

    Uint8List newChecksum;
    if (keyType == SHA256X2) {
      newChecksum = sha256x2(key).sublist(0, 4);
    } else {
      var check = key;
      if (keyType != null) {
        check = concat(key, utf8.encode(keyType) as Uint8List);
      }
      newChecksum = RIPEMD160Digest().process(check).sublist(0, 4);
    }
    if (decodeBigInt(checksum) != decodeBigInt(newChecksum)) {
      throw InvalidKey('checksum error');
    }
    return key;
  }

  /// Encode key to string format using base58 encoding
  static String encodeKey(Uint8List key, [String? keyType]) {
    if (keyType == SHA256X2) {
      var checksum = sha256x2(key).sublist(0, 4);
      return base58.encode(concat(key, checksum));
    }

    var keyBuffer = key;
    if (keyType != null) {
      keyBuffer = concat(key, utf8.encode(keyType) as Uint8List);
    }
    var checksum = RIPEMD160Digest().process(keyBuffer).sublist(0, 4);
    return base58.encode(concat(key, checksum));
  }

  /// Do SHA256 hash twice on the given data
  static Uint8List sha256x2(Uint8List data) {
    var d1 = sha256.convert(data);
    var d2 = sha256.convert(d1.bytes);
    return d2.bytes as Uint8List;
  }

  static Uint8List concat(Uint8List p1, Uint8List p2) {
    var keyList = p1.toList();
    keyList.addAll(p2);
    return Uint8List.fromList(keyList);
  }

  static List<int> toSigned(Uint8List bytes) {
    var result = <int>[];
    for (var i = 0; i < bytes.length; i++) {
      var v = bytes[i].toSigned(8);
      // ignore: todo
      //TODO I don't know why, just guess...
      if (i == 0 && v < 0) {
        result.add(0);
      }
      result.add(v);
    }
    return result;
  }
}
