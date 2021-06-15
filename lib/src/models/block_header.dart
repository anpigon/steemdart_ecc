class BlockHeader {
  final String previous; // block_id_type
  final String timestamp; // time_point_sec
  final String witness;
  final String transaction_merkle_root; // checksum_type
  final List<dynamic> extensions; // block_header_extensions_type

  BlockHeader({
    required this.previous,
    required this.timestamp,
    required this.witness,
    required this.transaction_merkle_root,
    required this.extensions,
  });

  factory BlockHeader.from(Map<String, dynamic> json) => BlockHeader(
        previous: json['previous'],
        timestamp: json['timestamp'],
        witness: json['witness'],
        transaction_merkle_root: json['transaction_merkle_root'],
        extensions: json['extensions'],
      );

  Map<String, dynamic> toJson() => {
        'previous': previous,
        'timestamp': timestamp,
        'witness': witness,
        'transaction_merkle_root': transaction_merkle_root,
        'extensions': extensions,
      };
}
