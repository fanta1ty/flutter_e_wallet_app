part of 'login_cubit.dart';

class LoginState {
  final LoadStatus loadStatus;
  LoginResponse? response;

  final String email;
  final String password;
  final bool isButtonEnabled;

  LoginState.init({
    this.loadStatus = LoadStatus.Init,
    this.email = '',
    this.password = '',
    this.isButtonEnabled = false,
  });

//<editor-fold desc="Data Methods">
  LoginState({
    required this.loadStatus,
    this.response,
    required this.email,
    required this.password,
    required this.isButtonEnabled,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoginState &&
          runtimeType == other.runtimeType &&
          loadStatus == other.loadStatus &&
          response == other.response &&
          email == other.email &&
          password == other.password &&
          isButtonEnabled == other.isButtonEnabled);

  @override
  int get hashCode =>
      loadStatus.hashCode ^
      response.hashCode ^
      email.hashCode ^
      password.hashCode ^
      isButtonEnabled.hashCode;

  @override
  String toString() {
    return 'LoginState{' +
        ' loadStatus: $loadStatus,' +
        ' response: $response,' +
        ' email: $email,' +
        ' password: $password,' +
        ' isButtonEnabled: $isButtonEnabled,' +
        '}';
  }

  LoginState copyWith({
    LoadStatus? loadStatus,
    LoginResponse? response,
    String? email,
    String? password,
    bool? isButtonEnabled,
  }) {
    return LoginState(
      loadStatus: loadStatus ?? this.loadStatus,
      response: response ?? this.response,
      email: email ?? this.email,
      password: password ?? this.password,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'loadStatus': this.loadStatus,
      'response': this.response,
      'email': this.email,
      'password': this.password,
      'isButtonEnabled': this.isButtonEnabled,
    };
  }

  factory LoginState.fromMap(Map<String, dynamic> map) {
    return LoginState(
      loadStatus: map['loadStatus'] as LoadStatus,
      response: map['response'] as LoginResponse,
      email: map['email'] as String,
      password: map['password'] as String,
      isButtonEnabled: map['isButtonEnabled'] as bool,
    );
  }

//</editor-fold>
}
