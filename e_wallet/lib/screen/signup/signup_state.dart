part of 'signup_cubit.dart';

class SignupState {
  final LoadStatus loadStatus;
  SignUpResponse? response;

  SignupState.init({this.loadStatus = LoadStatus.Init});

//<editor-fold desc="Data Methods">
  SignupState({
    required this.loadStatus,
    this.response,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SignupState &&
          runtimeType == other.runtimeType &&
          loadStatus == other.loadStatus &&
          response == other.response);

  @override
  int get hashCode => loadStatus.hashCode ^ response.hashCode;

  @override
  String toString() {
    return 'SignupState{' +
        ' loadStatus: $loadStatus,' +
        ' response: $response,' +
        '}';
  }

  SignupState copyWith({
    LoadStatus? loadStatus,
    SignUpResponse? response,
  }) {
    return SignupState(
      loadStatus: loadStatus ?? this.loadStatus,
      response: response ?? this.response,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'loadStatus': this.loadStatus,
      'response': this.response,
    };
  }

  factory SignupState.fromMap(Map<String, dynamic> map) {
    return SignupState(
      loadStatus: map['loadStatus'] as LoadStatus,
      response: map['response'] as SignUpResponse,
    );
  }

//</editor-fold>
}
