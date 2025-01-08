import 'package:e_wallet/constant/colours.dart';
import 'package:e_wallet/language_cubit.dart';
import 'package:e_wallet/main_cubit.dart';
import 'package:e_wallet/screen/more/more_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../l10n/app_localizations.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MoreCubit(),
      child: const MoreScreenContent(),
    );
  }
}

class MoreScreenContent extends StatefulWidget {
  const MoreScreenContent({super.key});

  @override
  State<MoreScreenContent> createState() => _MoreScreenContentState();
}

class _MoreScreenContentState extends State<MoreScreenContent> {
  @override
  Widget build(BuildContext context) {
    final mainCubit = context.read<MainCubit>();
    final mainState = context.watch<MainCubit>().state;

    final appLoc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: _buildAppBar(context, appLoc),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocBuilder<MoreCubit, MoreState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildSectionTitle(appLoc.settings),
              const SizedBox(height: 10),
              _buildCard(
                child: Column(
                  children: [
                    _buildLanguageSelector(context, appLoc.language),
                    const Divider(height: 1),
                    _buildSettingsTile(
                      title: appLoc.dark_mode,
                      icon: mainState.isDarkMode
                          ? Icons.nightlight_round
                          : Icons.wb_sunny,
                      trailing: Switch(
                        value: mainState.isDarkMode,
                        onChanged: (bool value) {
                          mainCubit.toggleTheme(value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Theme.of(context).cardColor,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: child,
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).textTheme.bodyLarge!.color,
      ),
    );
  }

  Widget _buildSettingsTile({
    required String title,
    required IconData icon,
    Widget? trailing,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.primary,
        size: 28,
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      trailing: trailing,
    );
  }

  AppBar _buildAppBar(BuildContext context, AppLocalizations appLoc) {
    return AppBar(
      backgroundColor: btntxt,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        appLoc.settings,
        style: const TextStyle(fontSize: 22, color: Colors.white),
      ),
      centerTitle: true,
      elevation: 2,
    );
  }

  Widget _buildLanguageSelector(BuildContext context, String currentLanguage) {
    final appLoc = AppLocalizations.of(context);

    return ListTile(
      leading: const Icon(Icons.language),
      title: Text(appLoc!.language),
      subtitle: Text(currentLanguage),
      onTap: () {
        _showLanguageDialog(context);
      },
    );
  }

  void _showLanguageDialog(BuildContext context) {
    final langCubit = context.read<LanguageCubit>();

    final List<Map<String, String>> languages = [
      {'name': 'English', 'code': 'en'},
      {'name': 'Tiếng Việt', 'code': 'vi'},
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.select_language),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: languages.map((lang) {
              return RadioListTile<String>(
                title: Text(lang['name']!),
                value: lang['code']!,
                groupValue: langCubit.state.languageCode,
                onChanged: (String? value) {
                  langCubit.changeLanguage(value!);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
