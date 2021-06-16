// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppliedOperation _$AppliedOperationFromJson(Map<String, dynamic> json) {
  return AppliedOperation(
    trx_id: json['trx_id'] as String,
    block: json['block'] as int,
    trx_in_block: json['trx_in_block'] as int,
    op_in_trx: json['op_in_trx'] as int,
    virtual_op: json['virtual_op'] as int,
    timestamp: json['timestamp'] as String,
    op: Operation.fromJson(json['op'] as List<dynamic>),
  );
}

Map<String, dynamic> _$AppliedOperationToJson(AppliedOperation instance) =>
    <String, dynamic>{
      'trx_id': instance.trx_id,
      'block': instance.block,
      'trx_in_block': instance.trx_in_block,
      'op_in_trx': instance.op_in_trx,
      'virtual_op': instance.virtual_op,
      'timestamp': instance.timestamp,
      'op': instance.op,
    };
