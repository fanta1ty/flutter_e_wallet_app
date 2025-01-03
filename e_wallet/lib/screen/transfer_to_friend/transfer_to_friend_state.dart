part of 'transfer_to_friend_cubit.dart';

class TransferToFriendState {
  final LoadStatus loadStatus;

  final bool isButtonEnabled;
  final bool isTransferSuccess;

  final String phone;
  final String notes;
  final String amount;
  final String to;
  final String date;

  TransferToFriendState.init({
    this.loadStatus = LoadStatus.Init,
    this.isButtonEnabled = false,
    this.isTransferSuccess = false,
    this.phone = '',
    this.notes = '',
    this.amount = '',
    this.to = '',
    this.date = '',
  });

//<editor-fold desc="Data Methods">
  const TransferToFriendState({
    required this.loadStatus,
    required this.isButtonEnabled,
    required this.isTransferSuccess,
    required this.phone,
    required this.notes,
    required this.amount,
    required this.to,
    required this.date,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransferToFriendState &&
          runtimeType == other.runtimeType &&
          loadStatus == other.loadStatus &&
          isButtonEnabled == other.isButtonEnabled &&
          isTransferSuccess == other.isTransferSuccess &&
          phone == other.phone &&
          notes == other.notes &&
          amount == other.amount &&
          to == other.to &&
          date == other.date);

  @override
  int get hashCode =>
      loadStatus.hashCode ^
      isButtonEnabled.hashCode ^
      isTransferSuccess.hashCode ^
      phone.hashCode ^
      notes.hashCode ^
      amount.hashCode ^
      to.hashCode ^
      date.hashCode;

  @override
  String toString() {
    return 'TransferToFriendState{' +
        ' loadStatus: $loadStatus,' +
        ' isButtonEnabled: $isButtonEnabled,' +
        ' isTransferSuccess: $isTransferSuccess,' +
        ' phone: $phone,' +
        ' notes: $notes,' +
        ' amount: $amount,' +
        ' to: $to,' +
        ' date: $date,' +
        '}';
  }

  TransferToFriendState copyWith({
    LoadStatus? loadStatus,
    bool? isButtonEnabled,
    bool? isTransferSuccess,
    String? phone,
    String? notes,
    String? amount,
    String? to,
    String? date,
  }) {
    return TransferToFriendState(
      loadStatus: loadStatus ?? this.loadStatus,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
      isTransferSuccess: isTransferSuccess ?? this.isTransferSuccess,
      phone: phone ?? this.phone,
      notes: notes ?? this.notes,
      amount: amount ?? this.amount,
      to: to ?? this.to,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'loadStatus': this.loadStatus,
      'isButtonEnabled': this.isButtonEnabled,
      'isTransferSuccess': this.isTransferSuccess,
      'phone': this.phone,
      'notes': this.notes,
      'amount': this.amount,
      'to': this.to,
      'date': this.date,
    };
  }

  factory TransferToFriendState.fromMap(Map<String, dynamic> map) {
    return TransferToFriendState(
      loadStatus: map['loadStatus'] as LoadStatus,
      isButtonEnabled: map['isButtonEnabled'] as bool,
      isTransferSuccess: map['isTransferSuccess'] as bool,
      phone: map['phone'] as String,
      notes: map['notes'] as String,
      amount: map['amount'] as String,
      to: map['to'] as String,
      date: map['date'] as String,
    );
  }

//</editor-fold>
}
