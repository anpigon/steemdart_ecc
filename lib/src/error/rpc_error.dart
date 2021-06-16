class RPCError implements Exception {
  late final int? code;
  late final String message;
  late final dynamic info;

  RPCError(
    this.message, {
    this.code,
    this.info,
  });

  @override
  String toString() {
    return message;
  }
}
