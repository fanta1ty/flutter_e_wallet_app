class WithdrawRequest {
  final String amount;
  final String date;

//<editor-fold desc="Data Methods">
  const WithdrawRequest({
    required this.amount,
    required this.date,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WithdrawRequest &&
          runtimeType == other.runtimeType &&
          amount == other.amount &&
          date == other.date);

  @override
  int get hashCode => amount.hashCode ^ date.hashCode;

  @override
  String toString() {
    return 'WithdrawRequest{' + ' amount: $amount,' + ' date: $date,' + '}';
  }

  WithdrawRequest copyWith({
    String? amount,
    String? date,
  }) {
    return WithdrawRequest(
      amount: amount ?? this.amount,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': this.amount,
      'date': this.date,
    };
  }

  factory WithdrawRequest.fromMap(Map<String, dynamic> map) {
    return WithdrawRequest(
      amount: map['amount'] as String,
      date: map['date'] as String,
    );
  }

//</editor-fold>
}
