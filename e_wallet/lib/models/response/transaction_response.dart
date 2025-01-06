class TransactionResponse {
  final String id;
  final String amount;
  final String note;
  final String phone;
  final String? date;
  final String? bankDate;
  final String bankCode;
  final String to;
  final String from;
  final String type;

//<editor-fold desc="Data Methods">
  const TransactionResponse({
    required this.id,
    required this.amount,
    required this.note,
    required this.phone,
    this.date,
    this.bankDate,
    required this.bankCode,
    required this.to,
    required this.from,
    required this.type,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionResponse &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          amount == other.amount &&
          note == other.note &&
          phone == other.phone &&
          date == other.date &&
          bankDate == other.bankDate &&
          bankCode == other.bankCode &&
          to == other.to &&
          from == other.from &&
          type == other.type);

  @override
  int get hashCode =>
      id.hashCode ^
      amount.hashCode ^
      note.hashCode ^
      phone.hashCode ^
      date.hashCode ^
      bankDate.hashCode ^
      bankCode.hashCode ^
      to.hashCode ^
      from.hashCode ^
      type.hashCode;

  @override
  String toString() {
    return 'TransactionResponse{' +
        ' id: $id,' +
        ' amount: $amount,' +
        ' note: $note,' +
        ' phone: $phone,' +
        ' date: $date,' +
        ' bankDate: $bankDate,' +
        ' bankCode: $bankCode,' +
        ' to: $to,' +
        ' from: $from,' +
        ' type: $type,' +
        '}';
  }

  TransactionResponse copyWith({
    String? id,
    String? amount,
    String? note,
    String? phone,
    String? date,
    String? bankDate,
    String? bankCode,
    String? to,
    String? from,
    String? type,
  }) {
    return TransactionResponse(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      phone: phone ?? this.phone,
      date: date ?? this.date,
      bankDate: bankDate ?? this.bankDate,
      bankCode: bankCode ?? this.bankCode,
      to: to ?? this.to,
      from: from ?? this.from,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'amount': this.amount,
      'note': this.note,
      'phone': this.phone,
      'date': this.date,
      'bankDate': this.bankDate,
      'bankCode': this.bankCode,
      'to': this.to,
      'from': this.from,
      'type': this.type,
    };
  }

  factory TransactionResponse.fromMap(
    Map<String, dynamic> map,
    String documentId,
  ) {
    return TransactionResponse(
      id: documentId,
      amount: map['amount'] as String,
      note: map['note'] as String,
      phone: map['phone'] as String,
      date: map['date'] as String,
      bankDate: map['bankDate'] as String,
      bankCode: map['bankCode'] as String,
      to: map['to'] as String,
      from: map['from'] as String,
      type: map['type'] as String,
    );
  }

//</editor-fold>
}
