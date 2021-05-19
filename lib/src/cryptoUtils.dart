import 'dart:typed_data';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

import '../steemdart_ecc.dart';
import './client.dart';
import './models/transaction.dart';
import './helpers/serializer.dart';

/**
 * Return copy of transaction with signature appended to signatures array.
 * @param transaction Transaction to sign.
 * @param keys Key(s) to sign transaction with.
 * @param options Chain id and address prefix, compatible with {@link Client}.
 */
SignedTransaction signTransaction(
  Transaction transaction,
  List<SteemPrivateKey> keys, [
  String chainId = DEFAULT_CHAIN_ID,
]) {
  final digest = transactionDigest(transaction.toMap(), chainId);
  List<String> signatures = [];
  for (final key in keys) {
    SteemSignature signature = key.signHash(digest);
    signatures.add(signature.toHex().toString());
  }

  return SignedTransaction(transaction, signatures);
}

/**
 * Return the sha256 transaction digest.
 * @param chainId The chain id to use when creating the hash.
 */
List<int> transactionDigest(Map<String, dynamic> transaction,
    [String chainId = DEFAULT_CHAIN_ID]) {
  BytesBuilder buffer = BytesBuilder(copy: true);
  try {
    TransactionSerializer.appendByteBuffer(buffer, transaction);
    final String transactionData = hex.encode(buffer.toBytes());
    final digest = sha256.convert([
      ...hex.decode(chainId),
      ...hex.decode(transactionData),
    ]).bytes;
    return digest;
  } catch (cause) {
    throw new Exception('Unable to serialize transaction');
  }
}
