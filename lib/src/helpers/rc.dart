import 'dart:core';
import 'dart:math' as math;

import '../client.dart';
import '../models/rc_account.dart';
import '../models/rc_params.dart';
import '../models/account.dart';
import '../models/asset.dart';

class RCAPI {
  final Client client;

  const RCAPI(this.client);

  /// Convenience for calling `rc_api`.
  Future<Map<String, dynamic>> call(String method, [var params]) async {
    return client.call('rc_api', method, params);
  }

  /// Returns RC data for array of usernames
  Future<List<RCAccount>> findRCAccounts(List<String> usernames) async {
    return await call('find_rc_accounts', {'accounts': usernames})
        .then((value) {
      return (value['result']['rc_accounts'] as List)
          .map((account) => RCAccount.fromJson(account))
          .toList();
    });
  }

  /// Returns the global resource params
  Future<RCParams> getResourceParams() async {
    final response = await call('get_resource_params', {});
    return RCParams.fromJson(response['result']['resource_params']);
  }

  /// Returns the global resource pool
  Future<RCPool> getResourcePool() async {
    final response = await call('get_resource_pool', {});
    return RCPool.fromJson(response['result']['resource_pool']);
  }

  /// Makes a API call and returns the RC mana-data for a specified username
  Future<Manabar> getRCMana(String username) async {
    final rc_account = (await findRCAccounts([username]))[0];
    return calculateRCMana(rc_account);
  }

  /// Makes a API call and returns the VP mana-data for a specified username
  Future<Manabar> getVPMana(String username) async {
    final account = (await client.database.getAccounts([username]))[0];
    return calculateVPMana(account);
  }

  /// Calculates the RC mana-data based on an RCAccount - findRCAccounts()
  Manabar calculateRCMana(RCAccount rc_account) {
    return _calculateManabar(
      rc_account.max_rc,
      rc_account.rc_manabar,
    );
  }

  /// Calculates the RC mana-data based on an Account - getAccounts()
  Manabar calculateVPMana(Account account) {
    final max_mana = getVests(account) * math.pow(10, 6);
    return _calculateManabar(
      max_mana,
      account.voting_manabar,
    );
  }

  /// Internal convenience method to reduce redundant code
  Manabar _calculateManabar(
    final max_mana,
    final RCManabar manabar,
  ) {
    final _delta =
        DateTime.now().millisecondsSinceEpoch / 1000 - manabar.last_update_time;
    final num current_mana = manabar.current_mana is String
        ? int.parse(manabar.current_mana)
        : manabar.current_mana;
    final num _max_mana = max_mana is String ? int.parse(max_mana) : max_mana;
    final calculated_current_mana = current_mana + _delta * _max_mana / 432000;
    var percentage = calculated_current_mana / _max_mana * 10000;
    if (!percentage.isFinite || percentage < 0) {
      percentage = 0;
    } else if (percentage > 10000) {
      percentage = 10000;
    }

    return Manabar(
      current_mana: calculated_current_mana,
      max_mana: _max_mana.round(),
      percentage: percentage.round(),
    );
  }

  double getVests(Account account,
      {subtract_delegated = true, add_received = true}) {
    var vests = Asset.from(account.vesting_shares);
    final vests_delegated = Asset.from(account.delegated_vesting_shares);
    final vests_received = Asset.from(account.received_vesting_shares);
    final withdraw_rate = Asset.from(account.vesting_withdraw_rate);

    final int to_withdraw = account.to_withdraw is String
        ? int.parse(account.to_withdraw)
        : account.to_withdraw;
    final int withdrawn = account.withdrawn is String
        ? int.parse(account.withdrawn)
        : account.to_withdraw;
    final already_withdrawn = to_withdraw - withdrawn / 1000000;
    final withdraw_vests = math.min(withdraw_rate.amount, already_withdrawn);
    vests = vests.subtract(withdraw_vests);

    if (subtract_delegated) {
      vests = vests.subtract(vests_delegated);
    }
    if (add_received) {
      vests = vests.add(vests_received);
    }

    return vests.amount;
  }
}
