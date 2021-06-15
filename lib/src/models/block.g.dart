// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlockHeader _$BlockHeaderFromJson(Map<String, dynamic> json) {
  return BlockHeader(
    previous: json['previous'] as String,
    timestamp: json['timestamp'] as String,
    witness: json['witness'] as String,
    transaction_merkle_root: json['transaction_merkle_root'] as String,
    extensions: json['extensions'] as List<dynamic>,
  );
}

Map<String, dynamic> _$BlockHeaderToJson(BlockHeader instance) =>
    <String, dynamic>{
      'previous': instance.previous,
      'timestamp': instance.timestamp,
      'witness': instance.witness,
      'transaction_merkle_root': instance.transaction_merkle_root,
      'extensions': instance.extensions,
    };

SignedBlockHeader _$SignedBlockHeaderFromJson(Map<String, dynamic> json) {
  return SignedBlockHeader(
    witness_signature: json['witness_signature'] as String,
    previous: json['previous'],
    timestamp: json['timestamp'],
    witness: json['witness'],
    transaction_merkle_root: json['transaction_merkle_root'],
    extensions: json['extensions'],
  );
}

Map<String, dynamic> _$SignedBlockHeaderToJson(SignedBlockHeader instance) =>
    <String, dynamic>{
      'previous': instance.previous,
      'timestamp': instance.timestamp,
      'witness': instance.witness,
      'transaction_merkle_root': instance.transaction_merkle_root,
      'extensions': instance.extensions,
      'witness_signature': instance.witness_signature,
    };

SignedBlock _$SignedBlockFromJson(Map<String, dynamic> json) {
  return SignedBlock(
    block_id: json['block_id'] as String,
    signing_key: json['signing_key'] as String,
    transaction_ids: (json['transaction_ids'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
    transactions: (json['transactions'] as List<dynamic>)
        .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
        .toList(),
    witness_signature: json['witness_signature'],
    previous: json['previous'],
    timestamp: json['timestamp'],
    witness: json['witness'],
    transaction_merkle_root: json['transaction_merkle_root'],
    extensions: json['extensions'],
  );
}

Map<String, dynamic> _$SignedBlockToJson(SignedBlock instance) =>
    <String, dynamic>{
      'previous': instance.previous,
      'timestamp': instance.timestamp,
      'witness': instance.witness,
      'transaction_merkle_root': instance.transaction_merkle_root,
      'extensions': instance.extensions,
      'witness_signature': instance.witness_signature,
      'block_id': instance.block_id,
      'signing_key': instance.signing_key,
      'transaction_ids': instance.transaction_ids,
      'transactions': instance.transactions,
    };
