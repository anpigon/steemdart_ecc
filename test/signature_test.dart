import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:steemdart_ecc/steemdart_ecc.dart';
import 'package:test/test.dart';
import 'package:crypto/crypto.dart';

void main() {
  group('Steem signature tests', () {
    test('Construct Steem signature from string', () {
      final sigStr =
          'SIG_K1_Kg417TSLuhzSpU2bGa21kD1UNaTfAZSCcKmKpZ6fnx3Nqu22gzG3ND4Twur7bzX8oS1J91JvV4rMJcFycGqFBSaY2SJcEQ';
      final signature = SteemSignature.fromString(sigStr);
      print(signature);

      expect(sigStr, signature.toString());
    });

    test('Sign the hash using private key', () {
      final privateKey = SteemPrivateKey.fromString(
          '5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3');
      final publicKey = privateKey.toPublicKey();
      final expectedSig =
          'SIG_K1_Kg417TSLuhzSpU2bGa21kD1UNaTfAZSCcKmKpZ6fnx3Nqu22gzG3ND4Twur7bzX8oS1J91JvV4rMJcFycGqFBSaY2SJcEQ';
      final expectedSigHex =
          '2056690438023bafdb50b9538e449d3eed41a4dbca2400a3b724d4a51d647ffd390aa752b3c89cfde12b06fa57d9ee56f89eb1e4a15d1cab1a79f4a1b3df278dd8';

      final data = 'data';
      final hashData = sha256.convert(utf8.encode(data)).bytes as Uint8List;
      print('hashData' + hex.encode(hashData));

      final signature = privateKey.signHash(hashData);
      final signature2 = privateKey.signString(data);

      expect(expectedSigHex, signature.toHex());

      print(signature.toString());
      expect(expectedSig, signature.toString());
      expect(true, signature.verifyHash(hashData, publicKey));
      expect(true, signature2.verifyHash(hashData, publicKey));

      expect(true, signature.verify(data, publicKey));
      expect(true, signature2.verify(data, publicKey));
    }, skip: true);

    test('Sign the hash using private key', () {
      final privateKey = SteemPrivateKey.fromString(
          '5HxT6prWB8VuXkoAaX3eby8bWjquMtCvGuakhC8tGEiPSHfsQLR');
      final publicKey = privateKey.toPublicKey();
      final expectedSig =
          'SIG_K1_Kdfe9wknSAKBmgwb3L53CG8KosoHhZ69oVEJrrH5YuWx4JVcJdn1ZV3MU25AVho4mPbeSKW79DVTBAAWj7zGbHTByF1JXU';

      final l = <int>[
        244,
        163,
        240,
        75,
        174,
        150,
        233,
        185,
        227,
        66,
        27,
        130,
        230,
        139,
        102,
        112,
        128,
        38,
        78,
        233,
        105,
        59,
        61,
        11,
        25,
        221,
        42,
        109,
        80,
        184,
        174,
        201
      ];
      final hashData = Uint8List.fromList(l);
      final signature = privateKey.signHash(hashData);

      expect(expectedSig, signature.toString());
      print(signature.toString());
      expect(true, signature.verifyHash(hashData, publicKey));
    }, skip: true);

    test('Sign the hash using private key', () {
      final privateKey = SteemPrivateKey.fromString(
          '5J9b3xMkbvcT6gYv2EpQ8FD4ZBjgypuNKwE1jxkd7Wd1DYzhk88');
      final publicKey = privateKey.toPublicKey();
      final expectedSig =
          'SIG_K1_KWfDGxwogny1PUiBAYTfKwPsCSNvM7zWgmXyChdYayZFfyPjddpBUYVdJTq1PjC3PRXADRsqWVU1N2SMQivBDqA7AaRzmB';

      final l = <int>[
        136,
        139,
        63,
        11,
        114,
        68,
        227,
        116,
        92,
        61,
        64,
        121,
        147,
        210,
        233,
        25,
        74,
        164,
        140,
        112,
        45,
        5,
        254,
        165,
        208,
        158,
        53,
        212,
        128,
        190,
        153,
        142
      ];
      final hashData = Uint8List.fromList(l);
      final signature = privateKey.signHash(hashData);

      expect(expectedSig, signature.toString());
      print(signature.toString());
      expect(true, signature.verifyHash(hashData, publicKey));
    }, skip: true);

    test('Recover PublicKey from sign data', () {
      const data = 'this is some data to sign';

      var PrivateKey = SteemPrivateKey.fromRandom();
      var PublicKey = PrivateKey.toPublicKey();

      var signature = PrivateKey.signString(data);

      var recoveredPublicKey = signature.recover(data);

      expect(PublicKey.toString(), recoveredPublicKey.toString());
      print('Generated PublicKey : ${PublicKey.toString()}');
      print('Recovered PublicKey : ${recoveredPublicKey.toString()}');
    }, skip: true);
  });
}
