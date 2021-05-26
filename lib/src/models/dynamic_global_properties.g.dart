// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_global_properties.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DynamicGlobalProperties _$DynamicGlobalPropertiesFromJson(
    Map<String, dynamic> json) {
  return DynamicGlobalProperties(
    head_block_number: json['head_block_number'] as int,
    head_block_id: json['head_block_id'] as String,
    time: json['time'] as String,
    current_witness: json['current_witness'] as String,
    total_pow: json['total_pow'] as int,
    num_pow_witnesses: json['num_pow_witnesses'] as int,
    virtual_supply: json['virtual_supply'] as String,
    current_supply: json['current_supply'] as String,
    confidential_supply: json['confidential_supply'] as String,
    init_sbd_supply: json['init_sbd_supply'] as String,
    current_sbd_supply: json['current_sbd_supply'] as String,
    confidential_sbd_supply: json['confidential_sbd_supply'] as String,
    total_vesting_fund_steem: json['total_vesting_fund_steem'] as String,
    total_vesting_shares: json['total_vesting_shares'] as String,
    total_reward_fund_steem: json['total_reward_fund_steem'] as String,
    total_reward_shares2: json['total_reward_shares2'] as String,
    pending_rewarded_vesting_shares:
        json['pending_rewarded_vesting_shares'] as String,
    pending_rewarded_vesting_steem:
        json['pending_rewarded_vesting_steem'] as String,
    sbd_interest_rate: json['sbd_interest_rate'] as int,
    sbd_print_rate: json['sbd_print_rate'] as int,
    maximum_block_size: json['maximum_block_size'] as int,
    required_actions_partition_percent:
        json['required_actions_partition_percent'] as int,
    current_aslot: json['current_aslot'] as int,
    recent_slots_filled: json['recent_slots_filled'] as String,
    participation_count: json['participation_count'] as int,
    last_irreversible_block_num: json['last_irreversible_block_num'] as int,
    vote_power_reserve_rate: json['vote_power_reserve_rate'] as int,
    delegation_return_period: json['delegation_return_period'] as int,
    reverse_auction_seconds: json['reverse_auction_seconds'] as int,
    available_account_subsidies: json['available_account_subsidies'] as int,
    sbd_stop_percent: json['sbd_stop_percent'] as int,
    sbd_start_percent: json['sbd_start_percent'] as int,
    next_maintenance_time: json['next_maintenance_time'] as String,
    last_budget_time: json['last_budget_time'] as String,
    content_reward_percent: json['content_reward_percent'] as int,
    vesting_reward_percent: json['vesting_reward_percent'] as int,
    sps_fund_percent: json['sps_fund_percent'] as int,
    sps_interval_ledger: json['sps_interval_ledger'] as String,
    downvote_pool_percent: json['downvote_pool_percent'] as int,
  );
}

Map<String, dynamic> _$DynamicGlobalPropertiesToJson(
        DynamicGlobalProperties instance) =>
    <String, dynamic>{
      'head_block_number': instance.head_block_number,
      'head_block_id': instance.head_block_id,
      'time': instance.time,
      'current_witness': instance.current_witness,
      'total_pow': instance.total_pow,
      'num_pow_witnesses': instance.num_pow_witnesses,
      'virtual_supply': instance.virtual_supply,
      'current_supply': instance.current_supply,
      'confidential_supply': instance.confidential_supply,
      'init_sbd_supply': instance.init_sbd_supply,
      'current_sbd_supply': instance.current_sbd_supply,
      'confidential_sbd_supply': instance.confidential_sbd_supply,
      'total_vesting_fund_steem': instance.total_vesting_fund_steem,
      'total_vesting_shares': instance.total_vesting_shares,
      'total_reward_fund_steem': instance.total_reward_fund_steem,
      'total_reward_shares2': instance.total_reward_shares2,
      'pending_rewarded_vesting_shares':
          instance.pending_rewarded_vesting_shares,
      'pending_rewarded_vesting_steem': instance.pending_rewarded_vesting_steem,
      'sbd_interest_rate': instance.sbd_interest_rate,
      'sbd_print_rate': instance.sbd_print_rate,
      'required_actions_partition_percent':
          instance.required_actions_partition_percent,
      'maximum_block_size': instance.maximum_block_size,
      'current_aslot': instance.current_aslot,
      'recent_slots_filled': instance.recent_slots_filled,
      'participation_count': instance.participation_count,
      'last_irreversible_block_num': instance.last_irreversible_block_num,
      'vote_power_reserve_rate': instance.vote_power_reserve_rate,
      'delegation_return_period': instance.delegation_return_period,
      'reverse_auction_seconds': instance.reverse_auction_seconds,
      'available_account_subsidies': instance.available_account_subsidies,
      'sbd_stop_percent': instance.sbd_stop_percent,
      'sbd_start_percent': instance.sbd_start_percent,
      'next_maintenance_time': instance.next_maintenance_time,
      'last_budget_time': instance.last_budget_time,
      'content_reward_percent': instance.content_reward_percent,
      'vesting_reward_percent': instance.vesting_reward_percent,
      'sps_fund_percent': instance.sps_fund_percent,
      'sps_interval_ledger': instance.sps_interval_ledger,
      'downvote_pool_percent': instance.downvote_pool_percent,
    };
