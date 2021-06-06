/// Asset symbol string.
const AssetSymbol = ['STEEM', 'VESTS', 'SBD', 'TESTS', 'TBD'];

/// Class representing a steem asset, e.g. `1.000 STEEM` or `12.112233 VESTS`.
class Asset {
  final double amount;
  final String symbol;

  Asset(this.amount, this.symbol)
      : assert(AssetSymbol.contains(symbol), 'Invalid asset symbol: $symbol');

  /// Create a new Asset instance from a string, e.g. `42.000 STEEM`.
  static Asset fromString(String string, [String? expectedSymbol]) {
    final splitedString = string.split(' ');
    final amountString = splitedString[0];
    final symbol = splitedString[1];
    if (!AssetSymbol.contains(symbol)) {
      throw Exception('Invalid asset symbol: $symbol');
    }
    if (expectedSymbol != null && symbol != expectedSymbol) {
      throw Exception(
          'Invalid asset, expected symbol: $expectedSymbol got: $symbol');
    }
    final amount = double.parse(amountString);
    if (!amount.isFinite) {
      throw Exception('Invalid asset amount: $amountString');
    }
    return Asset(amount, symbol);
  }

  /// Convenience to create new Asset.
  static Asset from(dynamic value, [String? symbol]) {
    if (value is Asset) {
      if (symbol != null && value.symbol != symbol) {
        throw Exception(
            'Invalid asset, expected symbol: $symbol got: ${value.symbol}');
      }
      return value;
    } else if (value is double && value.isFinite) {
      return Asset(value, symbol ?? 'STEEM');
    } else if (value is String) {
      return Asset.fromString(value, symbol);
    } else {
      throw Exception('Invalid asset \'$value\'');
    }
  }

  /// Return a new Asset instance with amount added.
  Asset add(dynamic amount) {
    final other = Asset.from(amount, symbol);
    assert(symbol == other.symbol, 'can not add with different symbols');
    return Asset(this.amount + other.amount, symbol);
  }

  /// Return a new Asset instance with amount subtracted.
  Asset subtract(dynamic amount) {
    final other = Asset.from(amount, symbol);
    assert(symbol == other.symbol, 'can not subtract with different symbols');
    return Asset(this.amount - other.amount, symbol);
  }

  // Return a new Asset with the amount multiplied by factor.
  Asset multiply(dynamic amount) {
    final other = Asset.from(amount, symbol);
    assert(symbol == other.symbol, 'can not multiply with different symbols');
    return Asset(this.amount * other.amount, symbol);
  }

  /// Return a new Asset with the amount divided.
  Asset divide(dynamic amount) {
    final other = Asset.from(amount, symbol);
    assert(symbol == other.symbol, 'can not divide with different symbols');
    return Asset(this.amount / other.amount, symbol);
  }

  // Return asset precision.
  int getPrecision() {
    switch (symbol) {
      case 'TESTS':
      case 'TBD':
      case 'STEEM':
      case 'SBD':
        return 3;
      case 'VESTS':
      default:
        return 6;
    }
  }

  /// Return a string representation of this asset, e.g. `42.000 STEEM`.
  @override
  String toString() {
    return '${amount.toStringAsFixed(getPrecision())} $symbol';
  }

  /// For JSON serialization, same as toString().
  String toJSON() {
    return toString();
  }
}
