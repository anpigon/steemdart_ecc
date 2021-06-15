class ChainProperties {
  final String account_creation_fee; // 3.000 STEEM
  final int maximum_block_size;
  final int sbd_interest_rate;

  ChainProperties({
    required this.account_creation_fee,
    required this.maximum_block_size,
    required this.sbd_interest_rate,
  });

  factory ChainProperties.fromJson(Map<String, dynamic> json) =>
      ChainProperties(
        account_creation_fee: json['account_creation_fee'],
        maximum_block_size: json['maximum_block_size'],
        sbd_interest_rate: json['sbd_interest_rate'],
      );

  Map<String, dynamic> toJson() => {
        'account_creation_fee': account_creation_fee,
        'maximum_block_size': maximum_block_size,
        'sbd_interest_rate': sbd_interest_rate,
      };
}
