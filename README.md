# Elliptic curve cryptography (ECC) in Dart

Elliptic curve cryptography lib for Steem based blockchain in Dart lang.

[![Build Status](https://travis-ci.com/anpigon/steemdart_ecc.svg?branch=master)](https://travis-ci.com/anpigon/steemdart_ecc)


## Usage

A simple usage example:

```dart
import 'package:steemdart_ecc/steemdart_ecc.dart';

main() {
  // Construct the Steem private key from string
  SteemPrivateKey privateKey = SteemPrivateKey.fromString(
      '5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3');

  // Get the related Steem public key
  SteemPublicKey publicKey = privateKey.toSteemPublicKey();
  // Print the Steem public key
  print(publicKey.toString());

  // Going to sign the data
  String data = 'data';

  // Sign
  SteemSignature signature = privateKey.signString(data);
  // Print the Steem signature
  print(signature.toString());

  // Verify the data using the signature
  signature.verify(data, publicKey);
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

## References

- eosjs-ecc: https://github.com/EOSIO/eosjs-ecc
- eosdart_ecc: https://github.com/primes-network/eosdart_ecc

[tracker]: https://github.com/anpigon/steemdart_ecc/issues
