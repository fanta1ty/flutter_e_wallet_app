part of 'history_detail_cubit.dart';

class HistoryDetailState {
  HistoryDetailState.init();

//<editor-fold desc="Data Methods">
  const HistoryDetailState();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HistoryDetailState && runtimeType == other.runtimeType);

  @override
  int get hashCode => 0;

  @override
  String toString() {
    return 'HistoryDetailState{' + '}';
  }

  HistoryDetailState copyWith() {
    return HistoryDetailState();
  }

  Map<String, dynamic> toMap() {
    return {};
  }

  factory HistoryDetailState.fromMap(Map<String, dynamic> map) {
    return HistoryDetailState();
  }

//</editor-fold>
}
