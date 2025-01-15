import 'package:e_wallet/constant/utils.dart';
import 'package:e_wallet/screen/profile/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant/colours.dart';
import '../../l10n/app_localizations.dart';
import '../../models/user_session.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: _ProfilePage(),
    );
  }
}

class _ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocConsumer<ProfileCubit, ProfileState>(
          builder: (context, state) {
            final appLoc = AppLocalizations.of(context)!;
            final userSession = UserSession();
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(
                    Theme.of(context),
                    userSession.email ?? "N/A",
                  ),
                  const SizedBox(height: 20),
                  _buildProfileItem(
                      context: context,
                      icon: Icons.person,
                      label: appLoc.name,
                      value: userSession.name ?? "Thinh Nguyen"),
                  const SizedBox(height: 20),
                  _buildProfileItem(
                    context: context,
                    icon: Icons.email,
                    label: appLoc.email,
                    value: userSession.email ?? "N/A",
                  ),
                  const SizedBox(height: 20),
                  _buildProfileItem(
                    context: context,
                    icon: Icons.phone,
                    label: appLoc.phone_number,
                    value: formattedPhone("0898417346"),
                  ),
                ],
              ),
            );
          },
          listener: (context, state) {}),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    return AppBar(
      title: Text(
        appLoc.profile,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      backgroundColor: btntxt,
    );
  }

  Widget _buildHeader(
    ThemeData theme,
    String email,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withOpacity(0.9),
            theme.colorScheme.secondary.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/image/avatar_1.png'),
            radius: 50,
            backgroundColor: Colors.white,
          ),
          const SizedBox(height: 15),
          Text(
            "Thinh Nguyen",
            style: theme.textTheme.titleLarge!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            email,
            style: theme.textTheme.bodyMedium!.copyWith(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                icon,
                size: 28,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
