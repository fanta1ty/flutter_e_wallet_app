class UserSession {
  static final UserSession _instance = UserSession._internal();

  factory UserSession() {
    return _instance;
  }

  UserSession._internal();

  String? userId;
  String? email;
  String? name;

  void clear() {
    userId = null;
    email = null;
    name = null;
  }

  bool get isLoggedIn => userId != null;
}
