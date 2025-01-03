class TransferRequest {
  final String amount;
  final String note;
  final String phone;
  final String date;
  final String bankDate;
  final String bankCode;
  final String to;
  final String from;

//<editor-fold desc="Data Methods">
  const TransferRequest({
    required this.amount,
    required this.note,
    required this.phone,
    required this.date,
    required this.bankDate,
    required this.bankCode,
    required this.to,
    required this.from,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransferRequest &&
          runtimeType == other.runtimeType &&
          amount == other.amount &&
          note == other.note &&
          phone == other.phone &&
          date == other.date &&
          bankDate == other.bankDate &&
          bankCode == other.bankCode &&
          to == other.to &&
          from == other.from);

  @override
  int get hashCode =>
      amount.hashCode ^
      note.hashCode ^
      phone.hashCode ^
      date.hashCode ^
      bankDate.hashCode ^
      bankCode.hashCode ^
      to.hashCode ^
      from.hashCode;

  @override
  String toString() {
    return 'TransferRequest{' +
        ' amount: $amount,' +
        ' note: $note,' +
        ' phone: $phone,' +
        ' date: $date,' +
        ' bankDate: $bankDate,' +
        ' bankCode: $bankCode,' +
        ' to: $to,' +
        ' from: $from,' +
        '}';
  }

  TransferRequest copyWith({
    String? amount,
    String? note,
    String? phone,
    String? date,
    String? bankDate,
    String? bankCode,
    String? to,
    String? from,
  }) {
    return TransferRequest(
      amount: amount ?? this.amount,
      note: note ?? this.note,
      phone: phone ?? this.phone,
      date: date ?? this.date,
      bankDate: bankDate ?? this.bankDate,
      bankCode: bankCode ?? this.bankCode,
      to: to ?? this.to,
      from: from ?? this.from,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': this.amount,
      'note': this.note,
      'phone': this.phone,
      'date': this.date,
      'bankDate': this.bankDate,
      'bankCode': this.bankCode,
      'to': this.to,
      'from': this.from,
    };
  }

  factory TransferRequest.fromMap(Map<String, dynamic> map) {
    return TransferRequest(
      amount: map['amount'] as String,
      note: map['note'] as String,
      phone: map['phone'] as String,
      date: map['date'] as String,
      bankDate: map['bankDate'] as String,
      bankCode: map['bankCode'] as String,
      to: map['to'] as String,
      from: map['from'] as String,
    );
  }

//</editor-fold>
}
