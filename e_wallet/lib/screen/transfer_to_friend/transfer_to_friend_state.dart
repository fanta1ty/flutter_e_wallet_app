part of 'transfer_to_friend_cubit.dart';

class TransferToFriendState {
  final LoadStatus loadStatus;

  final bool isButtonEnabled;
  final bool isTransferSuccess;

  TransferToFriendState.init(
      {this.loadStatus = LoadStatus.Init,
      this.isButtonEnabled = false,
      this.isTransferSuccess = false});

//<editor-fold desc="Data Methods">
  const TransferToFriendState({
    required this.loadStatus,
    required this.isButtonEnabled,
    required this.isTransferSuccess,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransferToFriendState &&
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
    return 'TransferToFriendState{' +
        ' loadStatus: $loadStatus,' +
        ' isButtonEnabled: $isButtonEnabled,' +
        ' isTransferSuccess: $isTransferSuccess,' +
        '}';
  }

  TransferToFriendState copyWith({
    LoadStatus? loadStatus,
    bool? isButtonEnabled,
    bool? isTransferSuccess,
  }) {
    return TransferToFriendState(
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

  factory TransferToFriendState.fromMap(Map<String, dynamic> map) {
    return TransferToFriendState(
      loadStatus: map['loadStatus'] as LoadStatus,
      isButtonEnabled: map['isButtonEnabled'] as bool,
      isTransferSuccess: map['isTransferSuccess'] as bool,
    );
  }

//</editor-fold>
}
