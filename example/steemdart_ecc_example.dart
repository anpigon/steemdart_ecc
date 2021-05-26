import 'package:steemdart_ecc/steemdart_ecc.dart';

void main() {
  // Construct the Steem private key from string
  final privateKey = SteemPrivateKey.fromString(
      '5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3');

  // Get the related Steem public key
  final publicKey = privateKey.toPublicKey();
  // Print the Steem public key
  print(publicKey.toString());

  // Going to sign the data
  final data = 'data';

  // Sign
  final signature = privateKey.signString(data);
  // Print the Steem signature
  print(signature.toString());

  // Recover the SteemPublicKey used to sign the data
  final recoveredSteemPublicKey = signature.recover(data);
  print(recoveredSteemPublicKey.toString());

  // Verify the data using the signature
  signature.verify(data, publicKey);
}
