part of 'more_cubit.dart';

class MoreState {
  final bool notificationsEnabled;
  final bool isDarkMode;
  final String selectedLanguage;

  MoreState.init({
    this.notificationsEnabled = true,
    this.isDarkMode = false,
    this.selectedLanguage = 'English',
  });

  //<editor-fold desc="Data Methods">
  const MoreState({
    required this.notificationsEnabled,
    required this.isDarkMode,
    required this.selectedLanguage,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MoreState &&
          runtimeType == other.runtimeType &&
          notificationsEnabled == other.notificationsEnabled &&
          isDarkMode == other.isDarkMode &&
          selectedLanguage == other.selectedLanguage);

  @override
  int get hashCode =>
      notificationsEnabled.hashCode ^
      isDarkMode.hashCode ^
      selectedLanguage.hashCode;

  @override
  String toString() {
    return 'MoreState{' +
        ' notificationsEnabled: $notificationsEnabled,' +
        ' isDarkMode: $isDarkMode,' +
        ' selectedLanguage: $selectedLanguage,' +
        '}';
  }

  MoreState copyWith({
    bool? notificationsEnabled,
    bool? isDarkMode,
    String? selectedLanguage,
  }) {
    return MoreState(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'notificationsEnabled': this.notificationsEnabled,
      'isDarkMode': this.isDarkMode,
      'selectedLanguage': this.selectedLanguage,
    };
  }

  factory MoreState.fromMap(Map<String, dynamic> map) {
    return MoreState(
      notificationsEnabled: map['notificationsEnabled'] as bool,
      isDarkMode: map['isDarkMode'] as bool,
      selectedLanguage: map['selectedLanguage'] as String,
    );
  }

//</editor-fold>
}
