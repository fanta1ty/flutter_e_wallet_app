part of 'main_cubit.dart';

enum AppTheme { light, dark }

class MainState {
  final ThemeData themeData;
  final bool isDarkMode;

  MainState.init({
    required this.themeData,
    required this.isDarkMode,
  });

//<editor-fold desc="Data Methods">
  const MainState({
    required this.themeData,
    required this.isDarkMode,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MainState &&
          runtimeType == other.runtimeType &&
          themeData == other.themeData &&
          isDarkMode == other.isDarkMode);

  @override
  int get hashCode => themeData.hashCode ^ isDarkMode.hashCode;

  @override
  String toString() {
    return 'MainState{' +
        ' themeData: $themeData,' +
        ' isDarkMode: $isDarkMode,' +
        '}';
  }

  MainState copyWith({
    ThemeData? themeData,
    bool? isDarkMode,
  }) {
    return MainState(
      themeData: themeData ?? this.themeData,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'themeData': this.themeData,
      'isDarkMode': this.isDarkMode,
    };
  }

  factory MainState.fromMap(Map<String, dynamic> map) {
    return MainState(
      themeData: map['themeData'] as ThemeData,
      isDarkMode: map['isDarkMode'] as bool,
    );
  }

//</editor-fold>
}
