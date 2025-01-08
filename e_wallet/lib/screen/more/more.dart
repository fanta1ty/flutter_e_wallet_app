import 'package:e_wallet/language_cubit.dart';
import 'package:e_wallet/main_cubit.dart';
import 'package:e_wallet/screen/more/more_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant/colours.dart';
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mainCubit = context.read<MainCubit>();
    final mainState = context.watch<MainCubit>().state;

    final appLoc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: _buildAppBar(context, appLoc),
      body: BlocBuilder<MoreCubit, MoreState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _buildLanguageSelector(context, appLoc.language),
              const Divider(height: 1, thickness: 0.5),
              _buildSettingsTile(
                title: appLoc.dark_mode,
                icon: Icons.dark_mode_outlined,
                trailing: Switch(
                  value: mainState.isDarkMode,
                  onChanged: (bool value) {
                    mainCubit.toggleTheme(value);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSettingsTile({
    required String title,
    required IconData icon,
    Widget? trailing,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      leading: Icon(icon, color: Colors.deepPurple, size: 28),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      trailing: trailing,
    );
  }

  AppBar _buildAppBar(
    BuildContext context,
    AppLocalizations appLoc,
  ) {
    return AppBar(
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
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      backgroundColor: btntxt,
    );
  }

  Widget _buildLanguageSelector(BuildContext context, String currentLanguage) {
    final appLoc = AppLocalizations.of(context);

    return ListTile(
      leading: const Icon(Icons.language, color: Colors.deepPurple),
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
