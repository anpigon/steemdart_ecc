/// Operation name.
enum OperationName {
  account_create, // 9
  account_create_with_delegation,
  account_update, // 10
  account_update2, // 43
  account_witness_proxy, // 13
  account_witness_vote, // 12
  cancel_transfer_from_savings, // 34
  change_recovery_account, // 26
  claim_account, // 22
  claim_reward_balance, // 39
  create_proposal, // 44
  comment, // 1
  comment_options, // 19
  convert, // 8
  create_claimed_account, // 23
  custom, // 15
  custom_binary, // 35
  custom_json, // 18
  decline_voting_rights, // 36
  delegate_vesting_shares, // 40
  delete_comment, // 17
  escrow_approve, // 31
  escrow_dispute, // 28
  escrow_release, // 29
  escrow_transfer, // 27
  feed_publish, // 7
  limit_order_cancel, // 6
  limit_order_create, // 5
  limit_order_create2, // 21
  pow, // 14
  pow2, // 30
  recover_account, // 25
  remove_proposal, // 46
  report_over_production, // 16
  request_account_recovery, // 24
  reset_account, // 37
  set_reset_account, // 38
  set_withdraw_vesting_route, // 20
  transfer, // 2
  transfer_from_savings, // 33
  transfer_to_savings, // 32
  transfer_to_vesting, // 3
  update_proposal_votes, // 45
  vote, // 0
  withdraw_vesting, // 4
  witness_set_properties, // 42
  witness_update, // 11
  producer_reward
}

/// Virtual operation name.
enum VirtualOperationName {
  author_reward, // 43
  comment_benefactor_reward, // 55
  comment_payout_update, // 53
  comment_reward, // 45
  curation_reward, // 44
  fill_convert_request, // 42
  fill_order, // 49
  fill_transfer_from_savings, // 51
  fill_vesting_withdraw, // 48
  hardfork, // 52
  interest, // 47
  liquidity_reward, // 46
  return_vesting_delegation, // 54
  shutdown_witness
}

class Operation {
  final String? _name;
  final Map<String, dynamic>? payload;

  OperationName? get name {
    final _opName =
        OperationName.values.where((e) => e.toString().endsWith(_name!));
    return _opName.isEmpty ? null : _opName.first;
  }

  VirtualOperationName? get virtual {
    final _opName =
        VirtualOperationName.values.where((e) => e.toString().endsWith(_name!));
    return _opName.isEmpty ? null : _opName.first;
  }

  String? get rawName {
    return _name;
  }

  const Operation(this._name, this.payload);

  List toJson() {
    return [_name, payload];
  }
}
