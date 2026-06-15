class TokenStorage {
  static final TokenStorage _instance = TokenStorage._internal();
  factory TokenStorage() => _instance;
  TokenStorage._internal();

  String? _token;
  String? get token => _token;
  set token(String? value) => _token = value;
}
