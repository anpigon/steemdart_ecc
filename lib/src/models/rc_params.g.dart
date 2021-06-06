// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rc_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RCParams _$RCParamsFromJson(Map<String, dynamic> json) {
  return RCParams(
    Resource.fromJson(json['resource_history_bytes'] as Map<String, dynamic>),
    Resource.fromJson(json['resource_new_accounts'] as Map<String, dynamic>),
    Resource.fromJson(json['resource_market_bytes'] as Map<String, dynamic>),
    Resource.fromJson(json['resource_state_bytes'] as Map<String, dynamic>),
    Resource.fromJson(json['resource_execution_time'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RCParamsToJson(RCParams instance) => <String, dynamic>{
      'resource_history_bytes': instance.resource_history_bytes,
      'resource_new_accounts': instance.resource_new_accounts,
      'resource_market_bytes': instance.resource_market_bytes,
      'resource_state_bytes': instance.resource_state_bytes,
      'resource_execution_time': instance.resource_execution_time,
    };

Resource _$ResourceFromJson(Map<String, dynamic> json) {
  return Resource(
    DynamicParam.fromJson(
        json['resource_dynamics_params'] as Map<String, dynamic>),
    PriceCurveParam.fromJson(
        json['price_curve_params'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ResourceToJson(Resource instance) => <String, dynamic>{
      'resource_dynamics_params': instance.resource_dynamics_params,
      'price_curve_params': instance.price_curve_params,
    };

DynamicParam _$DynamicParamFromJson(Map<String, dynamic> json) {
  return DynamicParam(
    json['resource_unit'] as int,
    json['budget_per_time_unit'] as int,
    json['pool_eq'],
    json['max_pool_size'],
    DecayParams.fromJson(json['decay_params'] as Map<String, dynamic>),
    json['min_decay'] as int,
  );
}

Map<String, dynamic> _$DynamicParamToJson(DynamicParam instance) =>
    <String, dynamic>{
      'resource_unit': instance.resource_unit,
      'budget_per_time_unit': instance.budget_per_time_unit,
      'pool_eq': instance.pool_eq,
      'max_pool_size': instance.max_pool_size,
      'decay_params': instance.decay_params,
      'min_decay': instance.min_decay,
    };

DecayParams _$DecayParamsFromJson(Map<String, dynamic> json) {
  return DecayParams(
    json['decay_per_time_unit'] as int,
    json['decay_per_time_unit_denom_shift'] as int,
  );
}

Map<String, dynamic> _$DecayParamsToJson(DecayParams instance) =>
    <String, dynamic>{
      'decay_per_time_unit': instance.decay_per_time_unit,
      'decay_per_time_unit_denom_shift':
          instance.decay_per_time_unit_denom_shift,
    };

PriceCurveParam _$PriceCurveParamFromJson(Map<String, dynamic> json) {
  return PriceCurveParam(
    json['coeff_a'],
    json['coeff_b'],
    json['shift'] as int,
  );
}

Map<String, dynamic> _$PriceCurveParamToJson(PriceCurveParam instance) =>
    <String, dynamic>{
      'coeff_a': instance.coeff_a,
      'coeff_b': instance.coeff_b,
      'shift': instance.shift,
    };

RCPool _$RCPoolFromJson(Map<String, dynamic> json) {
  return RCPool(
    Pool.fromJson(json['resource_history_bytes'] as Map<String, dynamic>),
    Pool.fromJson(json['resource_new_accounts'] as Map<String, dynamic>),
    Pool.fromJson(json['resource_market_bytes'] as Map<String, dynamic>),
    Pool.fromJson(json['resource_state_bytes'] as Map<String, dynamic>),
    Pool.fromJson(json['resource_execution_time'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RCPoolToJson(RCPool instance) => <String, dynamic>{
      'resource_history_bytes': instance.resource_history_bytes,
      'resource_new_accounts': instance.resource_new_accounts,
      'resource_market_bytes': instance.resource_market_bytes,
      'resource_state_bytes': instance.resource_state_bytes,
      'resource_execution_time': instance.resource_execution_time,
    };

Pool _$PoolFromJson(Map<String, dynamic> json) {
  return Pool(
    json['pool'],
  );
}

Map<String, dynamic> _$PoolToJson(Pool instance) => <String, dynamic>{
      'pool': instance.pool,
    };
