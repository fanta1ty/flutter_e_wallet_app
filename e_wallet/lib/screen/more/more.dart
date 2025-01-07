import 'package:e_wallet/screen/more/more_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class MoreScreenContent extends StatelessWidget {
  const MoreScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 2,
      ),
      body: BlocBuilder<MoreCubit, MoreState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _buildSettingsTile(
                title: 'Notifications',
                icon: Icons.notifications_active_outlined,
                trailing: Switch(
                  value: state.notificationsEnabled,
                  onChanged: (bool value) {
                    context.read<MoreCubit>().toggleNotifications(value);
                  },
                ),
              ),
              const Divider(height: 1, thickness: 0.5),
              _buildSettingsTile(
                title: 'Dark Mode',
                icon: Icons.dark_mode_outlined,
                trailing: Switch(
                  value: state.isDarkMode,
                  onChanged: (bool value) {
                    context.read<MoreCubit>().toggleDarkMode(value);
                  },
                ),
              ),
              const Divider(height: 1, thickness: 0.5),
              _buildLanguageSelector(context, state),
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

  Widget _buildLanguageSelector(BuildContext context, MoreState state) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      leading: const Icon(Icons.language_outlined,
          color: Colors.deepPurple, size: 28),
      title: const Text(
        'Language',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(state.selectedLanguage,
          style: const TextStyle(fontSize: 16, color: Colors.grey)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      onTap: () {
        _showLanguageSelectionDialog(context, state.selectedLanguage);
      },
    );
  }

  void _showLanguageSelectionDialog(
      BuildContext context, String selectedLanguage) {
    final List<String> languages = ['English', 'Spanish', 'French', 'German'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: languages.map((language) {
              return RadioListTile<String>(
                title: Text(language),
                value: language,
                groupValue: selectedLanguage,
                onChanged: (String? value) {
                  context.read<MoreCubit>().changeLanguage(value!);
                  Navigator.of(context).pop();
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
