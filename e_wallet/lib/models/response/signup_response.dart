class SignUpResponse {
  final bool success;
  final String errorMessage;

//<editor-fold desc="Data Methods">
  const SignUpResponse({
    required this.success,
    required this.errorMessage,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SignUpResponse &&
          runtimeType == other.runtimeType &&
          success == other.success &&
          errorMessage == other.errorMessage);

  @override
  int get hashCode => success.hashCode ^ errorMessage.hashCode;

  @override
  String toString() {
    return 'SignUpResponse{' +
        ' success: $success,' +
        ' errorMessage: $errorMessage,' +
        '}';
  }

  SignUpResponse copyWith({
    bool? success,
    String? errorMessage,
  }) {
    return SignUpResponse(
      success: success ?? this.success,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'success': this.success,
      'errorMessage': this.errorMessage,
    };
  }

  factory SignUpResponse.fromMap(Map<String, dynamic> map) {
    return SignUpResponse(
      success: map['success'] as bool,
      errorMessage: map['errorMessage'] as String,
    );
  }

//</editor-fold>
}
