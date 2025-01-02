part of 'transfer_to_contact_cubit.dart';

class TransferToContactState {
  final bool isButtonEnabled;
  final bool isProceedToTransfer;
  final bool isTransferSuccess;

  TransferToContactState.init(
      this.isButtonEnabled, this.isProceedToTransfer, this.isTransferSuccess);

//<editor-fold desc="Data Methods">
  const TransferToContactState({
    required this.isButtonEnabled,
    required this.isProceedToTransfer,
    required this.isTransferSuccess,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransferToContactState &&
          runtimeType == other.runtimeType &&
          isButtonEnabled == other.isButtonEnabled &&
          isProceedToTransfer == other.isProceedToTransfer &&
          isTransferSuccess == other.isTransferSuccess);

  @override
  int get hashCode =>
      isButtonEnabled.hashCode ^
      isProceedToTransfer.hashCode ^
      isTransferSuccess.hashCode;

  @override
  String toString() {
    return 'TransferToContactState{' +
        ' isButtonEnabled: $isButtonEnabled,' +
        ' isProceedToTransfer: $isProceedToTransfer,' +
        ' isTransferSuccess: $isTransferSuccess,' +
        '}';
  }

  TransferToContactState copyWith({
    bool? isButtonEnabled,
    bool? isProceedToTransfer,
    bool? isTransferSuccess,
  }) {
    return TransferToContactState(
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
      isProceedToTransfer: isProceedToTransfer ?? this.isProceedToTransfer,
      isTransferSuccess: isTransferSuccess ?? this.isTransferSuccess,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isButtonEnabled': this.isButtonEnabled,
      'isProceedToTransfer': this.isProceedToTransfer,
      'isTransferSuccess': this.isTransferSuccess,
    };
  }

  factory TransferToContactState.fromMap(Map<String, dynamic> map) {
    return TransferToContactState(
      isButtonEnabled: map['isButtonEnabled'] as bool,
      isProceedToTransfer: map['isProceedToTransfer'] as bool,
      isTransferSuccess: map['isTransferSuccess'] as bool,
    );
  }

//</editor-fold>
}
