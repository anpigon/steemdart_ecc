/// Node state.
class DynamicGlobalProperties {
  final String? id;

  /// Current block height.
  final int? head_block_number;
  final String? head_block_id;

  /// UTC Server time, e.g. 2020-01-15T00:42:00
  final String? time;

  /// Currently elected witness.
  final String? current_witness;

  /// The total POW accumulated, aka the sum of num_pow_witness at the time
  /// new POW is added.
  final int? total_pow;

  /// The current count of how many pending POW witnesses there are, determines
  /// the difficulty of doing pow.
  final int? num_pow_witnesses;
  final String? virtual_supply;
  final String? current_supply;

  /// Total asset held in confidential balances.
  final String? confidential_supply;
  final String? init_sbd_supply;
  final String? current_sbd_supply;

  /// Total asset held in confidential balances.
  final String? confidential_sbd_supply;
  final String? total_vesting_fund_steem;
  final String? total_vesting_shares;
  final String? total_reward_fund_steem;

  /// The running total of REWARD^2.
  final String? total_reward_shares2;
  final String? pending_rewarded_vesting_shares;
  final String? pending_rewarded_vesting_steem;

  /// This property defines the interest rate that SBD deposits receive.
  final int? sbd_interest_rate;
  final int? sbd_print_rate;

  ///  Average block size is updated every block to be:
  ///
  ///     average_block_size = (99 * average_block_size + new_block_size) / 100
  ///
  ///  This property is used to update the current_reserve_ratio to maintain
  ///  approximately 50% or less utilization of network capacity.
  final int? average_block_size;

  final int? required_actions_partition_percent;

  /// Maximum block size is decided by the set of active witnesses which change every round.
  /// Each witness posts what they think the maximum size should be as part of their witness
  /// properties, the median size is chosen to be the maximum block size for the round.
  ///
  /// @note the minimum value for maximum_block_size is defined by the protocol to prevent the
  /// network from getting stuck by witnesses attempting to set this too low.
  final int? maximum_block_size;

  /// The current absolute slot number. Equal to the total
  /// number of slots since genesis. Also equal to the total
  /// number of missed slots plus head_block_number.
  final int? current_aslot;

  /// Used to compute witness participation.
  final String? recent_slots_filled;
  final int? participation_count;
  final int? last_irreversible_block_num;

  /// The maximum bandwidth the blockchain can support is:
  ///
  ///    max_bandwidth = maximum_block_size * STEEMIT_BANDWIDTH_AVERAGE_WINDOW_SECONDS / STEEMIT_BLOCK_INTERVAL
  ///
  /// The maximum virtual bandwidth is:
  ///
  ///    max_bandwidth * current_reserve_ratio
  final String? max_virtual_bandwidth;

  /// Any time average_block_size <= 50% maximum_block_size this value grows by 1 until it
  /// reaches STEEMIT_MAX_RESERVE_RATIO.  Any time average_block_size is greater than
  /// 50% it falls by 1%.  Upward adjustments happen once per round, downward adjustments
  /// happen every block.
  final int? current_reserve_ratio;

  /// The number of votes regenerated per day.  Any user voting slower than this rate will be
  /// "wasting" voting power through spillover; any user voting faster than this rate will have
  /// their votes reduced.
  final int? vote_power_reserve_rate;

  final int? delegation_return_period;
  final int? reverse_auction_seconds;
  final int? available_account_subsidies;
  final int? sbd_stop_percent;
  final int? sbd_start_percent;
  final String? next_maintenance_time;
  final String? last_budget_time;
  final int? content_reward_percent;
  final int? vesting_reward_percent;
  final int? sps_fund_percent;
  final String? sps_interval_ledger;
  final int? downvote_pool_percent;

  DynamicGlobalProperties(Map<String, dynamic> value)
      : id = value['id'],
        head_block_number = value['result']['head_block_number'],
        head_block_id = value['result']['head_block_id'],
        time = value['result']['time'],
        current_witness = value['result']['current_witness'],
        total_pow = value['result']['total_pow'],
        num_pow_witnesses = value['result']['num_pow_witnesses'],
        virtual_supply = value['result']['virtual_supply'],
        current_supply = value['result']['current_supply'],
        confidential_supply = value['result']['confidential_supply'],
        init_sbd_supply = value['init_sbd_supply'],
        current_sbd_supply = value['result']['current_sbd_supply'],
        confidential_sbd_supply = value['result']['confidential_sbd_supply'],
        total_vesting_fund_steem = value['result']['total_vesting_fund_steem'],
        total_vesting_shares = value['result']['total_vesting_shares'],
        total_reward_fund_steem = value['result']['total_reward_fund_steem'],
        total_reward_shares2 = value['result']['total_reward_shares2'],
        pending_rewarded_vesting_shares =
            value['result']['pending_rewarded_vesting_shares'],
        pending_rewarded_vesting_steem =
            value['result']['pending_rewarded_vesting_steem'],
        sbd_interest_rate = value['result']['sbd_interest_rate'],
        sbd_print_rate = value['result']['sbd_print_rate'],
        average_block_size = value['result']['average_block_size'],
        maximum_block_size = value['result']['maximum_block_size'],
        required_actions_partition_percent =
            value['result']['required_actions_partition_percent'],
        current_aslot = value['result']['current_aslot'],
        recent_slots_filled = value['result']['recent_slots_filled'],
        participation_count = value['result']['participation_count'],
        last_irreversible_block_num =
            value['result']['last_irreversible_block_num'],
        max_virtual_bandwidth = value['result']['max_virtual_bandwidth'],
        current_reserve_ratio = value['result']['current_reserve_ratio'],
        vote_power_reserve_rate = value['result']['vote_power_reserve_rate'],
        delegation_return_period = value['result']['delegation_return_period'],
        reverse_auction_seconds = value['result']['reverse_auction_seconds'],
        available_account_subsidies =
            value['result']['available_account_subsidies'],
        sbd_stop_percent = value['result']['sbd_stop_percent'],
        sbd_start_percent = value['result']['sbd_start_percent'],
        next_maintenance_time = value['result']['next_maintenance_time'],
        last_budget_time = value['result']['last_budget_time'],
        content_reward_percent = value['result']['content_reward_percent'],
        vesting_reward_percent = value['result']['vesting_reward_percent'],
        sps_fund_percent = value['result']['sps_fund_percent'],
        sps_interval_ledger = value['result']['sps_interval_ledger'],
        downvote_pool_percent = value['result']['downvote_pool_percent'];
}
