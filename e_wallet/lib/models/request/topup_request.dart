class TopupRequest {
  final String amount;
  final String date;

//<editor-fold desc="Data Methods">
  const TopupRequest({
    required this.amount,
    required this.date,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TopupRequest &&
          runtimeType == other.runtimeType &&
          amount == other.amount &&
          date == other.date);

  @override
  int get hashCode => amount.hashCode ^ date.hashCode;

  @override
  String toString() {
    return 'TopupRequest{' + ' amount: $amount,' + ' date: $date,' + '}';
  }

  TopupRequest copyWith({
    String? amount,
    String? date,
  }) {
    return TopupRequest(
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

  factory TopupRequest.fromMap(Map<String, dynamic> map) {
    return TopupRequest(
      amount: map['amount'] as String,
      date: map['date'] as String,
    );
  }

//</editor-fold>
}
