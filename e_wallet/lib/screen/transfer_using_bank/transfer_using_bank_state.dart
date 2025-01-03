part of 'transfer_using_bank_cubit.dart';

class TransferUsingBankState {
  final LoadStatus loadStatus;

  final bool isButtonEnabled;
  final bool isTransferSuccess;

  TransferUsingBankState.init(
      {this.loadStatus = LoadStatus.Init,
      this.isButtonEnabled = false,
      this.isTransferSuccess = false});

//<editor-fold desc="Data Methods">
  const TransferUsingBankState({
    required this.loadStatus,
    required this.isButtonEnabled,
    required this.isTransferSuccess,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransferUsingBankState &&
          runtimeType == other.runtimeType &&
          loadStatus == other.loadStatus &&
          isButtonEnabled == other.isButtonEnabled &&
          isTransferSuccess == other.isTransferSuccess);

  @override
  int get hashCode =>
      loadStatus.hashCode ^
      isButtonEnabled.hashCode ^
      isTransferSuccess.hashCode;

  @override
  String toString() {
    return 'TransferUsingBankState{' +
        ' loadStatus: $loadStatus,' +
        ' isButtonEnabled: $isButtonEnabled,' +
        ' isTransferSuccess: $isTransferSuccess,' +
        '}';
  }

  TransferUsingBankState copyWith({
    LoadStatus? loadStatus,
    bool? isButtonEnabled,
    bool? isTransferSuccess,
  }) {
    return TransferUsingBankState(
      loadStatus: loadStatus ?? this.loadStatus,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
      isTransferSuccess: isTransferSuccess ?? this.isTransferSuccess,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'loadStatus': this.loadStatus,
      'isButtonEnabled': this.isButtonEnabled,
      'isTransferSuccess': this.isTransferSuccess,
    };
  }

  factory TransferUsingBankState.fromMap(Map<String, dynamic> map) {
    return TransferUsingBankState(
      loadStatus: map['loadStatus'] as LoadStatus,
      isButtonEnabled: map['isButtonEnabled'] as bool,
      isTransferSuccess: map['isTransferSuccess'] as bool,
    );
  }

//</editor-fold>
}
