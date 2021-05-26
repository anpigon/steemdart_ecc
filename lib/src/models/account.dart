/// ref: https://developers.steem.io/apidefinitions/#condenser_api.get_accounts
import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable()
class Authority {
  final int weight_threshold;
  final List<dynamic> account_auths;
  final List<dynamic> key_auths;

  const Authority({
    required this.weight_threshold,
    required this.account_auths,
    required this.key_auths,
  });

  factory Authority.fromJson(Map<String, dynamic> json) =>
      _$AuthorityFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorityToJson(this);
}

@JsonSerializable()
class Account {
  final int id; // account_id_type
  final String name; // account_name_type
  final Authority owner;
  final Authority active;
  final Authority posting;
  final String memo_key;
  final String json_metadata;
  final String proxy;
  final String last_owner_update;
  final String last_account_update;
  final String created;
  final bool mined;
  final String recovery_account;
  final String last_account_recovery;
  final String reset_account;
  final int comment_count;
  final int lifetime_vote_count;
  final int post_count;
  final bool can_vote;
  final int voting_power;
  final String last_vote_time;
  final String balance;
  final String savings_balance;
  final String sbd_balance;
  final String sbd_seconds;
  final String sbd_seconds_last_update;
  final String sbd_last_interest_payment;
  final String savings_sbd_balance;
  final String savings_sbd_seconds;
  final String savings_sbd_seconds_last_update;
  final String savings_sbd_last_interest_payment;
  final int savings_withdraw_requests;
  final String reward_sbd_balance;
  final String reward_steem_balance;
  final String reward_vesting_balance;
  final String reward_vesting_steem;
  final String vesting_shares;
  final String delegated_vesting_shares;
  final String received_vesting_shares;
  final String vesting_withdraw_rate;
  final String next_vesting_withdrawal;
  final int withdrawn;
  final int to_withdraw;
  final int withdraw_routes;
  final int curation_rewards;
  final int posting_rewards;
  final List<int> proxied_vsf_votes;
  final int witnesses_voted_for;
  final String last_post;
  final String last_root_post;
  final String vesting_balance;
  final String reputation;
  final List<dynamic> transfer_history;
  final List<dynamic> market_history;
  final List<dynamic> post_history;
  final List<dynamic> vote_history;
  final List<dynamic> other_history;
  final List<dynamic> witness_votes;
  final List<dynamic> tags_usage;
  final List<dynamic> guest_bloggers;

  Account({
    required this.id,
    required this.name,
    required this.owner,
    required this.active,
    required this.posting,
    required this.memo_key,
    required this.json_metadata,
    required this.proxy,
    required this.last_owner_update,
    required this.last_account_update,
    required this.created,
    required this.mined,
    required this.recovery_account,
    required this.last_account_recovery,
    required this.reset_account,
    required this.comment_count,
    required this.lifetime_vote_count,
    required this.post_count,
    required this.can_vote,
    required this.voting_power,
    required this.last_vote_time,
    required this.balance,
    required this.savings_balance,
    required this.sbd_balance,
    required this.sbd_seconds,
    required this.sbd_seconds_last_update,
    required this.sbd_last_interest_payment,
    required this.savings_sbd_balance,
    required this.savings_sbd_seconds,
    required this.savings_sbd_seconds_last_update,
    required this.savings_sbd_last_interest_payment,
    required this.savings_withdraw_requests,
    required this.reward_sbd_balance,
    required this.reward_steem_balance,
    required this.reward_vesting_balance,
    required this.reward_vesting_steem,
    required this.vesting_shares,
    required this.delegated_vesting_shares,
    required this.received_vesting_shares,
    required this.vesting_withdraw_rate,
    required this.next_vesting_withdrawal,
    required this.withdrawn,
    required this.to_withdraw,
    required this.withdraw_routes,
    required this.curation_rewards,
    required this.posting_rewards,
    required this.proxied_vsf_votes,
    required this.witnesses_voted_for,
    required this.last_post,
    required this.last_root_post,
    required this.vesting_balance,
    required this.reputation,
    required this.transfer_history,
    required this.market_history,
    required this.post_history,
    required this.vote_history,
    required this.other_history,
    required this.witness_votes,
    required this.tags_usage,
    required this.guest_bloggers,
  });

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
