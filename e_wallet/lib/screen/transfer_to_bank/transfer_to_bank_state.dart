part of 'transfer_to_bank_cubit.dart';

class TransferToBankState {
  final LoadStatus loadStatus;

  final bool isButtonEnabled;

  TransferToBankState.init({
    this.loadStatus = LoadStatus.Init,
    this.isButtonEnabled = false,
  });

//<editor-fold desc="Data Methods">
  const TransferToBankState({
    required this.loadStatus,
    required this.isButtonEnabled,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransferToBankState &&
          runtimeType == other.runtimeType &&
          loadStatus == other.loadStatus &&
          isButtonEnabled == other.isButtonEnabled);

  @override
  int get hashCode => loadStatus.hashCode ^ isButtonEnabled.hashCode;

  @override
  String toString() {
    return 'TransferToBankState{' +
        ' loadStatus: $loadStatus,' +
        ' isButtonEnabled: $isButtonEnabled,' +
        '}';
  }

  TransferToBankState copyWith({
    LoadStatus? loadStatus,
    bool? isButtonEnabled,
  }) {
    return TransferToBankState(
      loadStatus: loadStatus ?? this.loadStatus,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'loadStatus': this.loadStatus,
      'isButtonEnabled': this.isButtonEnabled,
    };
  }

  factory TransferToBankState.fromMap(Map<String, dynamic> map) {
    return TransferToBankState(
      loadStatus: map['loadStatus'] as LoadStatus,
      isButtonEnabled: map['isButtonEnabled'] as bool,
    );
  }

//</editor-fold>
}
