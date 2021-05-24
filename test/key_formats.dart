import 'package:test/test.dart';

import '../lib/src/key.dart';

const key = {
  "public_key": "STM7jDPoMwyjVH5obFmqzFNp4Ffp7G2nvC7FKFkrMBpo7Sy4uq5Mj",
  "private_key":
      "20991828d456b389d0768ed7fb69bf26b9bb87208dd699ef49f10481c20d3e18",
};

void main() {
  group('steem.auth: key_formats', () {
    test('Calcualtes public key from private key', () {
      SteemPrivateKey private_key = SteemPrivateKey.fromHex(key['private_key']!);
      SteemPublicKey public_key = private_key.toPublicKey();
      expect(key['public_key'], public_key.toPublicKeyString());
    });

    test('private_key.toHex()', () {
      SteemPrivateKey private_key = SteemPrivateKey.fromHex(key['private_key']!);
      expect(key['private_key'], private_key.toHex());
    });
  });
}
