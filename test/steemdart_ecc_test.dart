import 'package:test/test.dart';

import 'package:steemdart_ecc/steemdart_ecc.dart';

void main() {
  group('Steem Key tests', () {
    test('Construct Steem public key from string', () {
      final publicKey = SteemPublicKey.fromString(
          'STM8Qi58kbERkTJC7A4gabxYU4SbrAxStJHacoke4sf6AvJyEDZXj');
      print(publicKey);

      expect('STM8Qi58kbERkTJC7A4gabxYU4SbrAxStJHacoke4sf6AvJyEDZXj',
          publicKey.toString());
    });

    // test('Construct Steem public key from string PUB_K1 format', () {
    //   SteemPublicKey publicKey = SteemPublicKey.fromString(
    //       'PUB_K1_859gxfnXyUriMgUeThh1fWv3oqcpLFyHa3TfFYC4PK2Ht7beeX');
    //   print(publicKey);
    // });

    test('Construct Steem private key from string', () {
      // common private key
      final privateKey = SteemPrivateKey.fromString(
          '5J9b3xMkbvcT6gYv2EpQ8FD4ZBjgypuNKwE1jxkd7Wd1DYzhk88');
      expect('STM8Qi58kbERkTJC7A4gabxYU4SbrAxStJHacoke4sf6AvJyEDZXj',
          privateKey.toPublicKey().toString());
      expect('5J9b3xMkbvcT6gYv2EpQ8FD4ZBjgypuNKwE1jxkd7Wd1DYzhk88',
          privateKey.toString());
    });

    test('Invalid  private key', () {
      try {
        SteemPrivateKey.fromString(
            '5KYZdUEo39z3FPrtuX2QbbwGnNP5zTd7yyr2SC1j299sBCnWjsm');
        fail('Should be invalid private key');
      } on InvalidKey catch (e) {
        fail('Should throw InvalidKey exception: ${e.toString()}');
      }
    });

    test('Construct random  private key from seed', () {
      final privateKey = SteemPrivateKey.fromSeed('abc');
      print(privateKey);
      print(privateKey.toPublicKey());

      final privateKey2 = SteemPrivateKey.fromString(privateKey.toString());
      expect(privateKey.toPublicKey().toString(),
          privateKey2.toPublicKey().toString());
    }, skip: true);

    test('Construct random  private key', () {
      final privateKey = SteemPrivateKey.fromRandom();

      print(privateKey);
      print(privateKey.toPublicKey());

      final privateKey2 = SteemPrivateKey.fromString(privateKey.toString());
      expect(privateKey.toPublicKey().toString(),
          privateKey2.toPublicKey().toString());
    });

    test('Construct  private key from string in PVT format', () {
      // PVT private key
      final privateKey2 = SteemPrivateKey.fromString(
          'PVT_K1_2jH3nnhxhR3zPUcsKaWWZC9ZmZAnKm3GAnFD1xynGJE1Znuvjd');
      print(privateKey2);
    });

    test('Construct  private key from string with compress flag', () {
      // Compressed private key
      final privateKey3 = SteemPrivateKey.fromString(
          'L5TCkLizyYqjvKSy6jg1XM3Lc4uTDwwvHS2BYatyXSyoS8T5kC2z');
      print(privateKey3);
    });
  });
}
