part of 'withdraw_cubit.dart';

class WithdrawState {
  final LoadStatus loadStatus;

  final String amount;

  final String date;

  final bool isWithdrawSuccess;

  final bool isButtonEnabled;
  List<TransactionResponse> responses;

  WithdrawState.init({
    this.loadStatus = LoadStatus.Init,
    this.amount = '',
    this.date = '',
    this.isButtonEnabled = false,
    this.isWithdrawSuccess = false,
    this.responses = const [],
  });

//<editor-fold desc="Data Methods">
  WithdrawState({
    required this.loadStatus,
    required this.amount,
    required this.date,
    required this.isWithdrawSuccess,
    required this.isButtonEnabled,
    required this.responses,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WithdrawState &&
          runtimeType == other.runtimeType &&
          loadStatus == other.loadStatus &&
          amount == other.amount &&
          date == other.date &&
          isWithdrawSuccess == other.isWithdrawSuccess &&
          isButtonEnabled == other.isButtonEnabled &&
          responses == other.responses);

  @override
  int get hashCode =>
      loadStatus.hashCode ^
      amount.hashCode ^
      date.hashCode ^
      isWithdrawSuccess.hashCode ^
      isButtonEnabled.hashCode ^
      responses.hashCode;

  @override
  String toString() {
    return 'WithdrawState{' +
        ' loadStatus: $loadStatus,' +
        ' amount: $amount,' +
        ' date: $date,' +
        ' isWithdrawSuccess: $isWithdrawSuccess,' +
        ' isButtonEnabled: $isButtonEnabled,' +
        ' responses: $responses,' +
        '}';
  }

  WithdrawState copyWith({
    LoadStatus? loadStatus,
    String? amount,
    String? date,
    bool? isWithdrawSuccess,
    bool? isButtonEnabled,
    List<TransactionResponse>? responses,
  }) {
    return WithdrawState(
      loadStatus: loadStatus ?? this.loadStatus,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      isWithdrawSuccess: isWithdrawSuccess ?? this.isWithdrawSuccess,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
      responses: responses ?? this.responses,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'loadStatus': this.loadStatus,
      'amount': this.amount,
      'date': this.date,
      'isWithdrawSuccess': this.isWithdrawSuccess,
      'isButtonEnabled': this.isButtonEnabled,
      'responses': this.responses,
    };
  }

  factory WithdrawState.fromMap(Map<String, dynamic> map) {
    return WithdrawState(
      loadStatus: map['loadStatus'] as LoadStatus,
      amount: map['amount'] as String,
      date: map['date'] as String,
      isWithdrawSuccess: map['isWithdrawSuccess'] as bool,
      isButtonEnabled: map['isButtonEnabled'] as bool,
      responses: map['responses'] as List<TransactionResponse>,
    );
  }

//</editor-fold>
}
