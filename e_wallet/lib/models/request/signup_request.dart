class SignUpRequest {
  final String email;
  final String password;

  final String confirmPassword;

  SignUpRequest.init(this.email, this.password, this.confirmPassword);

//<editor-fold desc="Data Methods">
  const SignUpRequest({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SignUpRequest &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          password == other.password &&
          confirmPassword == other.confirmPassword);

  @override
  int get hashCode =>
      email.hashCode ^ password.hashCode ^ confirmPassword.hashCode;

  @override
  String toString() {
    return 'SignUpRequest{' +
        ' email: $email,' +
        ' password: $password,' +
        ' confirmPassword: $confirmPassword,' +
        '}';
  }

  SignUpRequest copyWith({
    String? email,
    String? password,
    String? confirmPassword,
  }) {
    return SignUpRequest(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': this.email,
      'password': this.password,
      'confirmPassword': this.confirmPassword,
    };
  }

  factory SignUpRequest.fromMap(Map<String, dynamic> map) {
    return SignUpRequest(
      email: map['email'] as String,
      password: map['password'] as String,
      confirmPassword: map['confirmPassword'] as String,
    );
  }

//</editor-fold>
}
