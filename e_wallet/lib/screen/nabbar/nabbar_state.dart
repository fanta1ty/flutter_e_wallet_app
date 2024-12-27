part of 'nabbar_cubit.dart';

class NabbarState {
  final int index;

  NabbarState.init({this.index = 0});

//<editor-fold desc="Data Methods">
  const NabbarState({
    required this.index,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NabbarState &&
          runtimeType == other.runtimeType &&
          index == other.index);

  @override
  int get hashCode => index.hashCode;

  @override
  String toString() {
    return 'NabbarState{' + ' index: $index,' + '}';
  }

  NabbarState copyWith({
    int? index,
  }) {
    return NabbarState(
      index: index ?? this.index,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'index': this.index,
    };
  }

  factory NabbarState.fromMap(Map<String, dynamic> map) {
    return NabbarState(
      index: map['index'] as int,
    );
  }

//</editor-fold>
}
