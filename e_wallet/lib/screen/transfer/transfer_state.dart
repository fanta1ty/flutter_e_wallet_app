part of 'transfer_cubit.dart';

class TransferState {
  TransferState.init();

//<editor-fold desc="Data Methods">
  const TransferState();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransferState && runtimeType == other.runtimeType);

  @override
  int get hashCode => 0;

  @override
  String toString() {
    return 'TransferState{' + '}';
  }

  TransferState copyWith() {
    return TransferState();
  }

  Map<String, dynamic> toMap() {
    return {};
  }

  factory TransferState.fromMap(Map<String, dynamic> map) {
    return TransferState();
  }

//</editor-fold>
}
