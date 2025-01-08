import 'package:e_wallet/main_cubit.dart';
import 'package:e_wallet/screen/more/more_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant/colours.dart';

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

    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocBuilder<MoreCubit, MoreState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _buildSettingsTile(
                title: 'Dark Mode',
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

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const Text(
        'Settings',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      backgroundColor: btntxt,
    );
  }
}
