part of 'transfer_to_bank_cubit.dart';

class TransferToBankState {
  final LoadStatus loadStatus;

  final bool isButtonEnabled;

  final bool isTransferSuccess;

  final String amount;
  final String notes;
  final String code;
  final String to;
  final String date;

  TransferToBankState.init({
    this.loadStatus = LoadStatus.Init,
    this.isButtonEnabled = false,
    this.isTransferSuccess = false,
    this.amount = '',
    this.notes = '',
    this.code = '',
    this.to = '',
    this.date = '',
  });

//<editor-fold desc="Data Methods">
  const TransferToBankState({
    required this.loadStatus,
    required this.isButtonEnabled,
    required this.isTransferSuccess,
    required this.amount,
    required this.notes,
    required this.code,
    required this.to,
    required this.date,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransferToBankState &&
          runtimeType == other.runtimeType &&
          loadStatus == other.loadStatus &&
          isButtonEnabled == other.isButtonEnabled &&
          isTransferSuccess == other.isTransferSuccess &&
          amount == other.amount &&
          notes == other.notes &&
          code == other.code &&
          to == other.to &&
          date == other.date);

  @override
  int get hashCode =>
      loadStatus.hashCode ^
      isButtonEnabled.hashCode ^
      isTransferSuccess.hashCode ^
      amount.hashCode ^
      notes.hashCode ^
      code.hashCode ^
      to.hashCode ^
      date.hashCode;

  @override
  String toString() {
    return 'TransferToBankState{' +
        ' loadStatus: $loadStatus,' +
        ' isButtonEnabled: $isButtonEnabled,' +
        ' isTransferSuccess: $isTransferSuccess,' +
        ' amount: $amount,' +
        ' notes: $notes,' +
        ' code: $code,' +
        ' to: $to,' +
        ' date: $date,' +
        '}';
  }

  TransferToBankState copyWith({
    LoadStatus? loadStatus,
    bool? isButtonEnabled,
    bool? isTransferSuccess,
    String? amount,
    String? notes,
    String? code,
    String? to,
    String? date,
  }) {
    return TransferToBankState(
      loadStatus: loadStatus ?? this.loadStatus,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
      isTransferSuccess: isTransferSuccess ?? this.isTransferSuccess,
      amount: amount ?? this.amount,
      notes: notes ?? this.notes,
      code: code ?? this.code,
      to: to ?? this.to,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'loadStatus': this.loadStatus,
      'isButtonEnabled': this.isButtonEnabled,
      'isTransferSuccess': this.isTransferSuccess,
      'amount': this.amount,
      'notes': this.notes,
      'code': this.code,
      'to': this.to,
      'date': this.date,
    };
  }

  factory TransferToBankState.fromMap(Map<String, dynamic> map) {
    return TransferToBankState(
      loadStatus: map['loadStatus'] as LoadStatus,
      isButtonEnabled: map['isButtonEnabled'] as bool,
      isTransferSuccess: map['isTransferSuccess'] as bool,
      amount: map['amount'] as String,
      notes: map['notes'] as String,
      code: map['code'] as String,
      to: map['to'] as String,
      date: map['date'] as String,
    );
  }

//</editor-fold>
}
