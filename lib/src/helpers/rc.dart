import 'dart:core';

import '../client.dart';
import '../models/rc_account.dart';
import '../models/rc_params.dart';

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

  /// Makes a API call and returns the RC mana-data for a specified username
  Future getRCMana(String username) async {
    final rc_account = (await findRCAccounts([username]))[0];
    return calculateRCMana(rc_account);
  }

  /// Calculates the RC mana-data based on an RCAccount - findRCAccounts()
  Manabar calculateRCMana(RCAccount rc_account) {
    return _calculateManabar(
      int.parse(rc_account.max_rc),
      current_mana: rc_account.rc_manabar.current_mana,
      last_update_time: rc_account.rc_manabar.last_update_time,
    );
  }

  /// Internal convenience method to reduce redundant code
  Manabar _calculateManabar(
    int max_mana, {
    required String current_mana,
    required int last_update_time,
  }) {
    final _delta =
        DateTime.now().millisecondsSinceEpoch / 1000 - last_update_time;
    final _current_mana =
        int.parse(current_mana) + (_delta * max_mana / 432000);
    var percentage = (_current_mana / max_mana * 10000).round();
    if (!percentage.isFinite || percentage < 0) {
      percentage = 0;
    } else if (percentage > 10000) {
      percentage = 10000;
    }

    return Manabar(
      current_mana: _current_mana,
      max_mana: max_mana,
      percentage: percentage,
    );
  }
}
