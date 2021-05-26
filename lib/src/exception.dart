class InvalidKey implements Exception {
  String cause;

  InvalidKey(this.cause);

  @override
  String toString() => cause;
}
