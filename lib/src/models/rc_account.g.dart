// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rc_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RCAccount _$RCAccountFromJson(Map<String, dynamic> json) {
  return RCAccount(
    account: json['account'] as String,
    rc_manabar: RCManabar.fromJson(json['rc_manabar'] as Map<String, dynamic>),
    max_rc: json['max_rc'],
    max_rc_creation_adjustment: MaxRCCreationAdjustment.fromJson(
        json['max_rc_creation_adjustment'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RCAccountToJson(RCAccount instance) => <String, dynamic>{
      'account': instance.account,
      'rc_manabar': instance.rc_manabar,
      'max_rc': instance.max_rc,
      'max_rc_creation_adjustment': instance.max_rc_creation_adjustment,
    };

RCManabar _$RCManabarFromJson(Map<String, dynamic> json) {
  return RCManabar(
    current_mana: json['current_mana'],
    last_update_time: json['last_update_time'] as int,
  );
}

Map<String, dynamic> _$RCManabarToJson(RCManabar instance) => <String, dynamic>{
      'current_mana': instance.current_mana,
      'last_update_time': instance.last_update_time,
    };

MaxRCCreationAdjustment _$MaxRCCreationAdjustmentFromJson(
    Map<String, dynamic> json) {
  return MaxRCCreationAdjustment(
    amount: json['amount'] as String,
    precision: json['precision'] as int,
    nai: json['nai'] as String,
  );
}

Map<String, dynamic> _$MaxRCCreationAdjustmentToJson(
        MaxRCCreationAdjustment instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'precision': instance.precision,
      'nai': instance.nai,
    };
