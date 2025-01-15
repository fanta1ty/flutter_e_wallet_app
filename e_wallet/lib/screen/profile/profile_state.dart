part of 'profile_cubit.dart';

class ProfileState {
  //<editor-fold desc="Data Methods">
  const ProfileState();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileState && runtimeType == other.runtimeType);

  @override
  int get hashCode => 0;

  @override
  String toString() {
    return 'ProfileState{' + '}';
  }

  ProfileState copyWith() {
    return ProfileState();
  }

  Map<String, dynamic> toMap() {
    return {};
  }

  factory ProfileState.fromMap(Map<String, dynamic> map) {
    return ProfileState();
  }

//</editor-fold>
}
