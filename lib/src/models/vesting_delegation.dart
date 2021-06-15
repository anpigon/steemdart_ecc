class VestingDelegation {
  /// Delegation id.
  final int id;

  /// Account that is delegating vests to delegatee.
  final String delegator;

  /// Account that is receiving vests from delegator.
  final String delegatee;

  /// Amount of VESTS delegated.
  final String vesting_shares;

  /// Earliest date delegation can be removed.
  final String min_delegation_time;

  VestingDelegation({
    required this.id,
    required this.delegator,
    required this.delegatee,
    required this.vesting_shares,
    required this.min_delegation_time,
  });

  factory VestingDelegation.fromJson(Map<String, dynamic> json) =>
      VestingDelegation(
        id: json['id'],
        delegator: json['delegator'],
        delegatee: json['delegatee'],
        vesting_shares: json['vesting_shares'],
        min_delegation_time: json['min_delegation_time'],
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'delegator': delegator,
    'delegatee': delegatee,
    'vesting_shares': vesting_shares,
    'min_delegation_time': min_delegation_time,
  };
}
