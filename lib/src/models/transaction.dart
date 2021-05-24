import './operation.dart';

class Transaction {
  final String? transaction_id;
  final int? transaction_num;
  final int? ref_block_num;
  final int? ref_block_prefix;
  final String? expiration;
  final List<Operation>? operations;
  final List? extensions;

  const Transaction({
    this.ref_block_num,
    this.ref_block_prefix,
    this.expiration,
    this.operations,
    this.extensions,
    this.transaction_id,
    this.transaction_num,
  });

  factory Transaction.fromMap(Map map) {
    return Transaction(
      transaction_id: map['transaction_id'],
      transaction_num: map['transaction_num'],
      ref_block_num: map['ref_block_num'],
      ref_block_prefix: map['ref_block_prefix'],
      expiration: map['expiration'],
      operations: map['operations'] is List
          ? map['operations']
              .map<Operation>((e) => Operation(e[0], e[1]))
              .toList()
          : map['operations'],
      extensions: map['extensions'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'expiration': this.expiration,
      'extensions': this.extensions,
      'operations':
          this.operations!.map<List>((operation) => operation.export()).toList(),
      if (this.transaction_id != null) ...{
        'transaction_id': this.transaction_id,
      },
      if (this.transaction_num != null) ...{
        'transaction_num': this.transaction_num,
      },
      'ref_block_num': this.ref_block_num,
      'ref_block_prefix': this.ref_block_prefix,
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

  factory SignedTransaction.fromMap(Map map) {
    Transaction tx = Transaction.fromMap(map);
    return SignedTransaction(
        tx,
        map['signatures'] is List
            ? map['signatures']
                .map<String>((signature) => signature.toString())
                .toList()
            : map['signatures']);
  }

  Map<String, dynamic> toJson() {
    return {
      ...super.toMap(),
      'signatures': this.signatures,
    };
  }
}
