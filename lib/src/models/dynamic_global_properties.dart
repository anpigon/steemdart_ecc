import 'package:json_annotation/json_annotation.dart';

part 'dynamic_global_properties.g.dart';

/// Node state.
/// ref: https://developers.steem.io/tutorials-recipes/understanding-dynamic-global-properties
@JsonSerializable()
class DynamicGlobalProperties {
  /// Current block height.
  final int head_block_number;
  final String head_block_id;

  /// UTC Server time, e.g. 2020-01-15T00:42:00
  final String time;

  /// Currently elected witness.
  final String current_witness;

  /// The total POW accumud, aka the sum of num_pow_witness at the time
  /// new POW is added.
  final int total_pow;

  /// The current count of how many pending POW witnesses there are, determines
  /// the difficulty of doing pow.
  final int num_pow_witnesses;
  final String virtual_supply;
  final String current_supply;

  /// Total asset held in confidential balances.
  final String confidential_supply;
  final String init_sbd_supply;
  final String current_sbd_supply;

  /// Total asset held in confidential balances.
  final String confidential_sbd_supply;
  final String total_vesting_fund_steem;
  final String total_vesting_shares;
  final String total_reward_fund_steem;

  /// The running total of REWARD^2.
  final String total_reward_shares2;
  final String pending_rewarded_vesting_shares;
  final String pending_rewarded_vesting_steem;

  /// This property defines the interest rate that SBD deposits receive.
  final int sbd_interest_rate;
  final int sbd_print_rate;

  final int required_actions_partition_percent;

  /// Maximum block size is decided by the set of active witnesses which change every round.
  /// Each witness posts what they think the maximum size should be as part of their witness
  /// properties, the median size is chosen to be the maximum block size for the round.
  ///
  /// @note the minimum value for maximum_block_size is defined by the protocol to prevent the
  /// network from getting stuck by witnesses attempting to set this too low.
  final int maximum_block_size;

  /// The current absolute slot number. Equal to the total
  /// number of slots since genesis. Also equal to the total
  /// number of missed slots plus head_block_number.
  final int current_aslot;

  /// Used to compute witness participation.
  final String recent_slots_filled;
  final int participation_count;
  final int last_irreversible_block_num;

  /// The number of votes regenerated per day.  Any user voting slower than this rate will be
  /// "wasting" voting power through spillover; any user voting faster than this rate will have
  /// their votes reduced.
  final int vote_power_reserve_rate;

  final int delegation_return_period;
  final int reverse_auction_seconds;
  final int available_account_subsidies;
  final int sbd_stop_percent;
  final int sbd_start_percent;
  final String next_maintenance_time;
  final String last_budget_time;
  final int content_reward_percent;
  final int vesting_reward_percent;
  final int sps_fund_percent;
  final String sps_interval_ledger;
  final int downvote_pool_percent;

  const DynamicGlobalProperties({
    required this.head_block_number,
    required this.head_block_id,
    required this.time,
    required this.current_witness,
    required this.total_pow,
    required this.num_pow_witnesses,
    required this.virtual_supply,
    required this.current_supply,
    required this.confidential_supply,
    required this.init_sbd_supply,
    required this.current_sbd_supply,
    required this.confidential_sbd_supply,
    required this.total_vesting_fund_steem,
    required this.total_vesting_shares,
    required this.total_reward_fund_steem,
    required this.total_reward_shares2,
    required this.pending_rewarded_vesting_shares,
    required this.pending_rewarded_vesting_steem,
    required this.sbd_interest_rate,
    required this.sbd_print_rate,
    required this.maximum_block_size,
    required this.required_actions_partition_percent,
    required this.current_aslot,
    required this.recent_slots_filled,
    required this.participation_count,
    required this.last_irreversible_block_num,
    required this.vote_power_reserve_rate,
    required this.delegation_return_period,
    required this.reverse_auction_seconds,
    required this.available_account_subsidies,
    required this.sbd_stop_percent,
    required this.sbd_start_percent,
    required this.next_maintenance_time,
    required this.last_budget_time,
    required this.content_reward_percent,
    required this.vesting_reward_percent,
    required this.sps_fund_percent,
    required this.sps_interval_ledger,
    required this.downvote_pool_percent,
  });

  factory DynamicGlobalProperties.fromJson(Map<String, dynamic> json) =>
      _$DynamicGlobalPropertiesFromJson(json);

  Map<String, dynamic> toJson() => _$DynamicGlobalPropertiesToJson(this);
}
