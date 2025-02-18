/// ref: https://developers.steem.io/apidefinitions/rc-api#rc_api.get_resource_params
import 'package:json_annotation/json_annotation.dart';

part 'rc_params.g.dart';

@JsonSerializable()
class RCParams {
  final Resource resource_history_bytes;
  final Resource resource_new_accounts;
  final Resource resource_market_bytes;
  final Resource resource_state_bytes;
  final Resource resource_execution_time;

  const RCParams(
    this.resource_history_bytes,
    this.resource_new_accounts,
    this.resource_market_bytes,
    this.resource_state_bytes,
    this.resource_execution_time,
  );

  factory RCParams.fromJson(Map<String, dynamic> json) =>
      _$RCParamsFromJson(json);

  Map<String, dynamic> toJson() => _$RCParamsToJson(this);
}

@JsonSerializable()
class Resource {
  final DynamicParam resource_dynamics_params;
  final PriceCurveParam price_curve_params;

  const Resource(
    this.resource_dynamics_params,
    this.price_curve_params,
  );

  factory Resource.fromJson(Map<String, dynamic> json) =>
      _$ResourceFromJson(json);

  Map<String, dynamic> toJson() => _$ResourceToJson(this);
}

@JsonSerializable()
class DynamicParam {
  final int resource_unit;
  final int budget_per_time_unit;
  final pool_eq; // int or String
  final max_pool_size; // int or String
  final DecayParams decay_params;
  final int min_decay;

  const DynamicParam(
    this.resource_unit,
    this.budget_per_time_unit,
    this.pool_eq,
    this.max_pool_size,
    this.decay_params,
    this.min_decay,
  );

  factory DynamicParam.fromJson(Map<String, dynamic> json) =>
      _$DynamicParamFromJson(json);

  Map<String, dynamic> toJson() => _$DynamicParamToJson(this);
}

@JsonSerializable()
class DecayParams {
  final int decay_per_time_unit;
  final int decay_per_time_unit_denom_shift;

  const DecayParams(
    this.decay_per_time_unit,
    this.decay_per_time_unit_denom_shift,
  );

  factory DecayParams.fromJson(Map<String, dynamic> json) =>
      _$DecayParamsFromJson(json);

  Map<String, dynamic> toJson() => _$DecayParamsToJson(this);
}

@JsonSerializable()
class PriceCurveParam {
  final coeff_a; // int or String
  final coeff_b; // int or String
  final int shift;

  const PriceCurveParam(
    this.coeff_a,
    this.coeff_b,
    this.shift,
  );

  factory PriceCurveParam.fromJson(Map<String, dynamic> json) =>
      _$PriceCurveParamFromJson(json);

  Map<String, dynamic> toJson() => _$PriceCurveParamToJson(this);
}

@JsonSerializable()
class RCPool {
  final Pool resource_history_bytes;
  final Pool resource_new_accounts;
  final Pool resource_market_bytes;
  final Pool resource_state_bytes;
  final Pool resource_execution_time;

  const RCPool(
    this.resource_history_bytes,
    this.resource_new_accounts,
    this.resource_market_bytes,
    this.resource_state_bytes,
    this.resource_execution_time,
  );

  factory RCPool.fromJson(Map<String, dynamic> json) => _$RCPoolFromJson(json);

  Map<String, dynamic> toJson() => _$RCPoolToJson(this);
}

@JsonSerializable()
class Pool {
  final pool; // int or String

  const Pool(
    this.pool,
  );

  factory Pool.fromJson(Map<String, dynamic> json) => _$PoolFromJson(json);

  Map<String, dynamic> toJson() => _$PoolToJson(this);
}
