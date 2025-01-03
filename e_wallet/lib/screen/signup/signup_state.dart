part of 'signup_cubit.dart';

class SignupState {
  final LoadStatus loadStatus;
  SignUpResponse? response;

  final String email;
  final String password;
  final String confirmPassword;

  final bool isButtonEnabled;

  SignupState.init({
    this.loadStatus = LoadStatus.Init,
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.isButtonEnabled = false,
  });

//<editor-fold desc="Data Methods">
  SignupState({
    required this.loadStatus,
    this.response,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.isButtonEnabled,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SignupState &&
          runtimeType == other.runtimeType &&
          loadStatus == other.loadStatus &&
          response == other.response &&
          email == other.email &&
          password == other.password &&
          confirmPassword == other.confirmPassword &&
          isButtonEnabled == other.isButtonEnabled);

  @override
  int get hashCode =>
      loadStatus.hashCode ^
      response.hashCode ^
      email.hashCode ^
      password.hashCode ^
      confirmPassword.hashCode ^
      isButtonEnabled.hashCode;

  @override
  String toString() {
    return 'SignupState{' +
        ' loadStatus: $loadStatus,' +
        ' response: $response,' +
        ' email: $email,' +
        ' password: $password,' +
        ' confirmPassword: $confirmPassword,' +
        ' isButtonEnabled: $isButtonEnabled,' +
        '}';
  }

  SignupState copyWith({
    LoadStatus? loadStatus,
    SignUpResponse? response,
    String? email,
    String? password,
    String? confirmPassword,
    bool? isButtonEnabled,
  }) {
    return SignupState(
      loadStatus: loadStatus ?? this.loadStatus,
      response: response ?? this.response,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'loadStatus': this.loadStatus,
      'response': this.response,
      'email': this.email,
      'password': this.password,
      'confirmPassword': this.confirmPassword,
      'isButtonEnabled': this.isButtonEnabled,
    };
  }

  factory SignupState.fromMap(Map<String, dynamic> map) {
    return SignupState(
      loadStatus: map['loadStatus'] as LoadStatus,
      response: map['response'] as SignUpResponse,
      email: map['email'] as String,
      password: map['password'] as String,
      confirmPassword: map['confirmPassword'] as String,
      isButtonEnabled: map['isButtonEnabled'] as bool,
    );
  }

//</editor-fold>
}
