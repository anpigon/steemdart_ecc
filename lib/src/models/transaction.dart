import './operation.dart';

class Transaction {
  final String? transaction_id;
  final int? transaction_num;
  final int ref_block_num;
  final int ref_block_prefix;
  final String expiration;
  final List<Operation> operations;
  final List extensions;

  const Transaction({
    required this.ref_block_num,
    required this.ref_block_prefix,
    required this.expiration,
    required this.operations,
    required this.extensions,
    this.transaction_id,
    this.transaction_num,
  });

  factory Transaction.fromJson(Map map) {
    return Transaction(
      transaction_id: map['transaction_id'],
      transaction_num: map['transaction_num'],
      ref_block_num: map['ref_block_num'],
      ref_block_prefix: map['ref_block_prefix'],
      expiration: map['expiration'],
      operations: map['operations'] is List
          ? map['operations']
              .map<Operation>((e) => Operation.fromJson(e))
              .toList()
          : map['operations'],
      extensions: map['extensions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'expiration': expiration,
      'extensions': extensions,
      'operations':
          operations!.map<List>((operation) => operation.toJson()).toList(),
      if (transaction_id != null) ...{
        'transaction_id': transaction_id,
      },
      if (transaction_num != null) ...{
        'transaction_num': transaction_num,
      },
      'ref_block_num': ref_block_num,
      'ref_block_prefix': ref_block_prefix,
    };
  }
}

class SignedTransaction extends Transaction {
  final List<String>? signatures;

  SignedTransaction(Transaction tx, this.signatures)
      : super(
          ref_block_num: tx.ref_block_num,
          ref_block_prefix: tx.ref_block_prefix,
          expiration: tx.expiration,
          operations: tx.operations,
          extensions: tx.extensions,
        );

  factory SignedTransaction.fromJson(Map<String, dynamic> map) {
    var tx = Transaction.fromJson(map);
    return SignedTransaction(
        tx,
        map['signatures'] is List
            ? map['signatures']
                .map<String>((signature) => signature.toString())
                .toList()
            : map['signatures']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'signatures': signatures,
    };
  }
}
