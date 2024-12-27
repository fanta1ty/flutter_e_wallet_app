part of 'main_cubit.dart';

class MainState {
  MainState.name();

//<editor-fold desc="Data Methods">
  const MainState();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MainState && runtimeType == other.runtimeType);

  @override
  int get hashCode => 0;

  @override
  String toString() {
    return 'MainState{' + '}';
  }

  MainState copyWith() {
    return MainState();
  }

  Map<String, dynamic> toMap() {
    return {};
  }

  factory MainState.fromMap(Map<String, dynamic> map) {
    return MainState();
  }

//</editor-fold>
}
