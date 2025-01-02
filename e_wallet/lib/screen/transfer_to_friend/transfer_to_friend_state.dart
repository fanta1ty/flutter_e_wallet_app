part of 'transfer_to_friend_cubit.dart';

class TransferToFriendState {
  final bool isButtonEnabled;

  TransferToFriendState.init(this.isButtonEnabled);

//<editor-fold desc="Data Methods">
  const TransferToFriendState({
    required this.isButtonEnabled,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransferToFriendState &&
          runtimeType == other.runtimeType &&
          isButtonEnabled == other.isButtonEnabled);

  @override
  int get hashCode => isButtonEnabled.hashCode;

  @override
  String toString() {
    return 'TransferToFriendState{' +
        ' isButtonEnabled: $isButtonEnabled,' +
        '}';
  }

  TransferToFriendState copyWith({
    bool? isButtonEnabled,
  }) {
    return TransferToFriendState(
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isButtonEnabled': this.isButtonEnabled,
    };
  }

  factory TransferToFriendState.fromMap(Map<String, dynamic> map) {
    return TransferToFriendState(
      isButtonEnabled: map['isButtonEnabled'] as bool,
    );
  }

//</editor-fold>
}
