part of 'login_cubit.dart';

class LoginState {
  final LoadStatus loadStatus;
  LoginResponse? response;

  LoginState.init({this.loadStatus = LoadStatus.Init});

//<editor-fold desc="Data Methods">

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoginState &&
          runtimeType == other.runtimeType &&
          loadStatus == other.loadStatus);

  @override
  int get hashCode => loadStatus.hashCode;

  LoginState({
    required this.loadStatus,
    this.response,
  });

  @override
  String toString() {
    return 'LoginState{loadStatus: $loadStatus}';
  }

  Map<String, dynamic> toMap() {
    return {
      'loadStatus': this.loadStatus,
      'response': this.response,
    };
  }

  factory LoginState.fromMap(Map<String, dynamic> map) {
    return LoginState(
      loadStatus: map['loadStatus'] as LoadStatus,
      response: map['response'] as LoginResponse,
    );
  }

  LoginState copyWith({
    LoadStatus? loadStatus,
    LoginResponse? response,
  }) {
    return LoginState(
      loadStatus: loadStatus ?? this.loadStatus,
      response: response ?? this.response,
    );
  }
//</editor-fold>
}
