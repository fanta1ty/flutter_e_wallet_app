class LoginResponse {
  final bool success;
  final String errorMessage;
  final String? email;
  final String? displayName;

//<editor-fold desc="Data Methods">

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoginResponse &&
          runtimeType == other.runtimeType &&
          success == other.success &&
          errorMessage == other.errorMessage);

  @override
  int get hashCode => success.hashCode ^ errorMessage.hashCode;

  @override
  String toString() {
    return 'LoginResponse{' +
        ' success: $success,' +
        ' errorMessage: $errorMessage,' +
        '}';
  }

  const LoginResponse({
    required this.success,
    required this.errorMessage,
    this.email,
    this.displayName,
  });

  LoginResponse.name(
      this.success, this.errorMessage, this.email, this.displayName);

  Map<String, dynamic> toMap() {
    return {
      'success': this.success,
      'errorMessage': this.errorMessage,
      'email': this.email,
      'displayName': this.displayName,
    };
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      success: map['success'] as bool,
      errorMessage: map['errorMessage'] as String,
      email: map['email'] as String,
      displayName: map['displayName'] as String,
    );
  }

  LoginResponse copyWith({
    bool? success,
    String? errorMessage,
    String? email,
    String? displayName,
  }) {
    return LoginResponse(
      success: success ?? this.success,
      errorMessage: errorMessage ?? this.errorMessage,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
    );
  } //</editor-fold>
}
