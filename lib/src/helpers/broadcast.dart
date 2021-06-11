import 'dart:developer' as developer;

import '../../steemdart_ecc.dart';
import '../models/operation.dart';
import '../models/transaction.dart';
import '../client.dart';
import '../crypto_utils.dart';
import './utils.dart';

class BroadcastAPI {
  final Client client;

  /// How many milliseconds in the future to set the expiry time to when
  /// broadcasting a transaction, defaults to 1 minute.
  final int expireTime = 60 * 1000;

  const BroadcastAPI(this.client);

  /// Broadcast a comment, also used to create a new top level post.
  /// @param comment The comment/post.
  /// @param key Private posting key of comment author.
  Future<Map<String, dynamic>> comment(
      Map<String, dynamic> comment, SteemPrivateKey key) async {
    final op = Operation('comment', comment);
    return await sendOperations([op], key);
  }

  /// Broadcast a transfer.
  /// @param data The transfer operation payload.
  /// @param key Private active key of sender.
  Future<Map<String, dynamic>> transfer(
      Map<String, dynamic> data, SteemPrivateKey key) async {
    final op = Operation('transfer', data);
    return await sendOperations([op], key);
  }

  /// Sign and broadcast transaction with operations to the network. Throws if the transaction expires.
  /// @param operations List of operations to send.
  /// @param key Private key(s) used to sign transaction.
  Future<Map<String, dynamic>> sendOperations(
      List<Operation> operations, SteemPrivateKey key) async {
    final props = await client.database.getDynamicGlobalProperties();
    final ref_block_num = props.head_block_number & 0xFFFF;
    final ref_block_prefix = readUInt32LE(props.head_block_id, 4);
    final expiration = DateTime.parse(props.time)
        .add(Duration(milliseconds: expireTime))
        .toIso8601String()
        .substring(0, 19);
    final extensions = [];
    final tx = Transaction(
      expiration: expiration,
      extensions: extensions,
      operations: operations,
      ref_block_num: ref_block_num,
      ref_block_prefix: ref_block_prefix,
    );
    final signedTx = sign(tx, key);
    final result = await send(signedTx);
    assert(result['result']['expired'] == false, 'transaction expired');
    return result;
  }

  /// Broadcast a signed transaction to the network.
  Future<Map<String, dynamic>> send(SignedTransaction transaction) async {
    return call('broadcast_transaction_synchronous', [transaction]);
  }

  /// Convenience for calling `condenser_api`.
  Future<Map<String, dynamic>> call(String method, dynamic params) async {
    return client.call('condenser_api', method, params);
  }

  /// Sign a transaction with key(s).
  SignedTransaction sign(Transaction transaction, SteemPrivateKey key) {
    return signTransaction(transaction, [key], client.chainId);
  }
}
