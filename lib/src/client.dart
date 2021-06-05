import 'dart:convert';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

import './helpers/database.dart';
import './helpers/broadcast.dart';
import './helpers/rc.dart';

/// Library version.
const VERSION = '0.0.1';

/// Main steem network chain id.
const DEFAULT_CHAIN_ID =
    '0000000000000000000000000000000000000000000000000000000000000000';

/// Main steem network address prefix.
const DEFAULT_ADDRESS_PREFIX = 'STM';

class Client {
  final String address;
  final String chainId;
  final String addressPrefix;

  late DatabaseAPI _database;
  DatabaseAPI get database => _database;

  late BroadcastAPI _broadcast;
  BroadcastAPI get broadcast => _broadcast;

  late RCAPI _rc;
  RCAPI get rc => _rc;

  Client(
    this.address, {
    this.chainId = DEFAULT_CHAIN_ID,
    this.addressPrefix = DEFAULT_ADDRESS_PREFIX,
  }) {
    assert(chainId.length == 64, 'invalid chain id');

    _database = DatabaseAPI(this);
    _broadcast = BroadcastAPI(this);
    _rc = RCAPI(this);
  }

  Future<Map<String, dynamic>> call(
    String api,
    String method,
    dynamic params, {
    int? retries,
    bool Function(http.BaseResponse)? when,
    bool Function(Object, StackTrace)? whenError,
    Duration Function(int retryCount)? delay,
    void Function(http.BaseRequest, http.BaseResponse?, int retryCount)?
        onRetry,
  }) async {
    try {
      final url = Uri.parse(address);
      final headers = <String, String>{
        'User-Agent': 'dartsteem_ecc/$VERSION',
      };
      final request = <String, dynamic>{
        'id': '0',
        'jsonrpc': '2.0',
        'method': 'call',
        'params': [
          api,
          method,
          params ?? [],
        ],
      };
      final body = jsonEncode(request);
      final client = RetryClient(
        http.Client(),
        retries: retries ?? 3,
        when:
            when ?? (http.BaseResponse response) => response.statusCode == 503,
        whenError: whenError ?? (Object error, StackTrace stackTrace) => false,
        delay: delay ??
            (int retryCount) =>
                const Duration(milliseconds: 500) * math.pow(1.5, retryCount),
        onRetry: onRetry,
      );
      final response = await client.post(url, headers: headers, body: body);
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
      rethrow;
    }
  }
}
