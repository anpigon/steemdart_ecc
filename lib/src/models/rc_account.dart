import 'package:json_annotation/json_annotation.dart';

part 'rc_account.g.dart';

@JsonSerializable()

/// ref: https://developers.steem.io/apidefinitions/rc-api#rc_api.find_rc_accounts
class RCAccount {
  final String account;
  final RCManabar rc_manabar;
  final String max_rc;
  final MaxRCCreationAdjustment max_rc_creation_adjustment;

  const RCAccount({
    required this.account,
    required this.rc_manabar,
    required this.max_rc,
    required this.max_rc_creation_adjustment,
  });

  factory RCAccount.fromJson(Map<String, dynamic> json) =>
      _$RCAccountFromJson(json);

  Map<String, dynamic> toJson() => _$RCAccountToJson(this);
}

@JsonSerializable()
class RCManabar {
  final String current_mana;
  final int last_update_time;

  const RCManabar({
    required this.current_mana,
    required this.last_update_time,
  });

  factory RCManabar.fromJson(Map<String, dynamic> json) =>
      _$RCManabarFromJson(json);

  Map<String, dynamic> toJson() => _$RCManabarToJson(this);
}

@JsonSerializable()
class MaxRCCreationAdjustment {
  final String amount;
  final int precision;
  final String nai;

  const MaxRCCreationAdjustment({
    required this.amount,
    required this.precision,
    required this.nai,
  });

  factory MaxRCCreationAdjustment.fromJson(Map<String, dynamic> json) =>
      _$MaxRCCreationAdjustmentFromJson(json);

  Map<String, dynamic> toJson() => _$MaxRCCreationAdjustmentToJson(this);
}

class Manabar {
  final double current_mana;
  final int max_mana;
  final int percentage;

  Manabar({
    required this.current_mana,
    required this.max_mana,
    required this.percentage,
  });
}
