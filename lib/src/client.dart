import 'dart:convert';
import 'package:http/http.dart' as http;

import './helpers/database.dart';
import './helpers/broadcast.dart';

/**
 * Library version.
 */
const VERSION = '0.0.1';

/**
 * Main steem network chain id.
 */
const DEFAULT_CHAIN_ID =
    '0000000000000000000000000000000000000000000000000000000000000000';

/**
 * Main steem network address prefix.
 */
const DEFAULT_ADDRESS_PREFIX = 'STM';

class Client {
  final String address;
  final String chainId;
  final String addressPrefix;

  DatabaseAPI _database;
  DatabaseAPI get database => _database;

  BroadcastAPI _broadcast;
  BroadcastAPI get broadcast => _broadcast;

  Client(
    this.address, {
    this.chainId = DEFAULT_CHAIN_ID,
    this.addressPrefix = DEFAULT_ADDRESS_PREFIX,
  }) {
    assert(this.chainId.length == 64, 'invalid chain id');

    this._database = DatabaseAPI(this);
    this._broadcast = BroadcastAPI(this);
  }

  Future<Map<String, dynamic>> call(String api, String method,
      [var params]) async {
    try {
      final url = Uri.parse(address);
      final Map<String, String> headers = {
        'User-Agent': 'dartsteem_ecc/$VERSION',
      };
      final Map<String, dynamic> request = {
        'id': '0',
        'jsonrpc': '2.0',
        'method': 'call',
        'params': [
          api,
          method,
          params != null ? params : [],
        ],
      };
      final body = jsonEncode(request);
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.body);
        assert(result['id'] == request['id'], 'got invalid response id');
        if (result.containsKey('error')) {
          throw Exception(result['error']);
        }
        return result;
      }
      throw Exception(response.body);
    } catch (e) {
      throw e;
    }
  }
}
