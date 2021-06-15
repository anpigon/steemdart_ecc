import 'package:json_annotation/json_annotation.dart';

import './transaction.dart';

part 'block.g.dart';

/// Unsigned block header.
@JsonSerializable()
class BlockHeader {
  final String previous; // block_id_type
  final String timestamp; // time_point_sec
  final String witness;
  final String transaction_merkle_root; // checksum_type
  final List<dynamic> extensions; // block_header_extensions_type

  BlockHeader({
    required this.previous,
    required this.timestamp,
    required this.witness,
    required this.transaction_merkle_root,
    required this.extensions,
  });

  factory BlockHeader.fromJson(Map<String, dynamic> json) =>
      _$BlockHeaderFromJson(json);

  Map<String, dynamic> toJson() => _$BlockHeaderToJson(this);
}

/// Signed block header.
@JsonSerializable()
class SignedBlockHeader extends BlockHeader {
  final String witness_signature; // signature_type

  SignedBlockHeader({
    required this.witness_signature,
    previous,
    timestamp,
    witness,
    transaction_merkle_root,
    extensions,
  }) : super(
          previous: previous,
          timestamp: timestamp,
          witness: witness,
          transaction_merkle_root: transaction_merkle_root,
          extensions: extensions,
        );

  factory SignedBlockHeader.fromJson(Map<String, dynamic> json) =>
      _$SignedBlockHeaderFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SignedBlockHeaderToJson(this);
}

/// Full signed block.
@JsonSerializable()
class SignedBlock extends SignedBlockHeader {
  final String block_id;
  final String signing_key;
  final List<String> transaction_ids;
  final List<Transaction> transactions;

  SignedBlock({
    required this.block_id,
    required this.signing_key,
    required this.transaction_ids,
    required this.transactions,
    witness_signature,
    previous,
    timestamp,
    witness,
    transaction_merkle_root,
    extensions,
  }) : super(
          witness_signature: witness_signature,
          previous: previous,
          timestamp: timestamp,
          witness: witness,
          transaction_merkle_root: transaction_merkle_root,
          extensions: extensions,
        );

  factory SignedBlock.fromJson(Map<String, dynamic> json) =>
      _$SignedBlockFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SignedBlockToJson(this);
}
