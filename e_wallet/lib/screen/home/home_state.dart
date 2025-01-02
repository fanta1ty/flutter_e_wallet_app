part of 'home_cubit.dart';

class HomeState {
  HomeState.init();

//<editor-fold desc="Data Methods">
  const HomeState();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HomeState && runtimeType == other.runtimeType);

  @override
  int get hashCode => 0;

  @override
  String toString() {
    return 'HomeState{' + '}';
  }

  HomeState copyWith() {
    return HomeState();
  }

  Map<String, dynamic> toMap() {
    return {};
  }

  factory HomeState.fromMap(Map<String, dynamic> map) {
    return HomeState();
  }

//</editor-fold>
}
