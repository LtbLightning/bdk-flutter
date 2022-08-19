
class WalletException implements Exception {
  final String message;
  WalletException({required this.message}) ;
  @override
  String toString() {
    return 'WalletException: $message';
  }
}
class BroadcastException implements Exception {
  final String message;
  BroadcastException({required this.message}) ;
  @override
  String toString() {
    return 'BroadcastException: $message';
  }
}
class KeyException implements Exception {
  final String message;
  KeyException({required this.message}) ;
  @override
  String toString() {
    return 'KeyException: $message';
  }
}
