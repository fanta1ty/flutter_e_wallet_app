part of 'topup_cubit.dart';

class TopUpState {
  final LoadStatus loadStatus;
  final String amount;
  final String date;
  final bool isButtonEnabled;
  final bool isTopUpSuccess;
  List<TransactionResponse> responses;

  TopUpState.init({
    this.loadStatus = LoadStatus.Init,
    this.amount = '',
    this.date = '',
    this.isButtonEnabled = false,
    this.isTopUpSuccess = false,
    this.responses = const [],
  });

//<editor-fold desc="Data Methods">
  TopUpState({
    required this.loadStatus,
    required this.amount,
    required this.date,
    required this.isButtonEnabled,
    required this.isTopUpSuccess,
    required this.responses,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TopUpState &&
          runtimeType == other.runtimeType &&
          loadStatus == other.loadStatus &&
          amount == other.amount &&
          date == other.date &&
          isButtonEnabled == other.isButtonEnabled &&
          isTopUpSuccess == other.isTopUpSuccess &&
          responses == other.responses);

  @override
  int get hashCode =>
      loadStatus.hashCode ^
      amount.hashCode ^
      date.hashCode ^
      isButtonEnabled.hashCode ^
      isTopUpSuccess.hashCode ^
      responses.hashCode;

  @override
  String toString() {
    return 'TopUpState{' +
        ' loadStatus: $loadStatus,' +
        ' amount: $amount,' +
        ' date: $date,' +
        ' isButtonEnabled: $isButtonEnabled,' +
        ' isTopUpSuccess: $isTopUpSuccess,' +
        ' responses: $responses,' +
        '}';
  }

  TopUpState copyWith({
    LoadStatus? loadStatus,
    String? amount,
    String? date,
    bool? isButtonEnabled,
    bool? isTopUpSuccess,
    List<TransactionResponse>? responses,
  }) {
    return TopUpState(
      loadStatus: loadStatus ?? this.loadStatus,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
      isTopUpSuccess: isTopUpSuccess ?? this.isTopUpSuccess,
      responses: responses ?? this.responses,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'loadStatus': this.loadStatus,
      'amount': this.amount,
      'date': this.date,
      'isButtonEnabled': this.isButtonEnabled,
      'isTopUpSuccess': this.isTopUpSuccess,
      'responses': this.responses,
    };
  }

  factory TopUpState.fromMap(Map<String, dynamic> map) {
    return TopUpState(
      loadStatus: map['loadStatus'] as LoadStatus,
      amount: map['amount'] as String,
      date: map['date'] as String,
      isButtonEnabled: map['isButtonEnabled'] as bool,
      isTopUpSuccess: map['isTopUpSuccess'] as bool,
      responses: map['responses'] as List<TransactionResponse>,
    );
  }

//</editor-fold>
}
