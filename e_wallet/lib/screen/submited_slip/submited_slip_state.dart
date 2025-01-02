part of 'submited_slip_cubit.dart';

class SubmitedSlipState {
  SubmitedSlipState.init();

//<editor-fold desc="Data Methods">
  const SubmitedSlipState();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SubmitedSlipState && runtimeType == other.runtimeType);

  @override
  int get hashCode => 0;

  @override
  String toString() {
    return 'SubmitedSlipState{' + '}';
  }

  SubmitedSlipState copyWith() {
    return SubmitedSlipState();
  }

  Map<String, dynamic> toMap() {
    return {};
  }

  factory SubmitedSlipState.fromMap(Map<String, dynamic> map) {
    return SubmitedSlipState();
  }

//</editor-fold>
}
