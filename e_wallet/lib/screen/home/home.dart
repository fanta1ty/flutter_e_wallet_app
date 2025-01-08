import 'package:e_wallet/screen/home/home_cubit.dart';
import 'package:e_wallet/screen/more/more.dart';
import 'package:e_wallet/screen/topup/topup.dart';
import 'package:e_wallet/screen/withdraw/withdraw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/colours.dart';
import '../../constant/load_status.dart';
import '../../constant/utils.dart';
import '../../l10n/app_localizations.dart';
import '../../models/response/transaction_response.dart';
import '../../repositories/api/api.dart';
import '../transfer/transfer.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(context.read<Api>())..fetchTransactions(),
      child: const _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.loadStatus == LoadStatus.Loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SafeArea(
            child: CustomScrollView(
              slivers: [
                _buildHeader(context),
                _buildLatestTransactions(context, state.responses),
              ],
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    return SliverToBoxAdapter(
      child: Container(
        height: 289,
        color: btntxt,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/image/logo-in.png', height: 30),
                  _buildPointsBadge(context),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(appLoc.your_balance,
                    style: TextStyle(color: Colors.white, fontSize: 19)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(formatAmount("100"),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                    const Icon(Icons.remove_red_eye_rounded,
                        color: Colors.white)
                  ],
                ),
              ],
            ),
            _buildRoundedBottom(),
            _buildActionBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPointsBadge(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    return Container(
      width: 130,
      height: 40,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star, color: Color(0xFFffa41c)),
            Text('0 ${appLoc.points}')
          ],
        ),
      ),
    );
  }

  Widget _buildRoundedBottom() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 50,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.vertical(top: Radius.elliptical(300, 40))),
      ),
    );
  }

  Widget _buildActionBar(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    return Positioned(
      top: 200,
      left: 30,
      right: 30,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Colors.grey,
                spreadRadius: 2,
                blurRadius: 9,
                offset: Offset(0, 3))
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildActionItem(context, appLoc.transfer, 'transfer 1.png',
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Transfer()))),
            _buildActionItem(context, appLoc.top_up, 'icon-wtihdraw.png',
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TopUpScreen()))),
            _buildActionItem(context, appLoc.withdraw, 'icon-wallet.png',
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WithdrawScreen()))),
            _buildActionItem(context, appLoc.more, 'icon-more.png',
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MoreScreen()))),
          ],
        ),
      ),
    );
  }

  Widget _buildActionItem(BuildContext context, String label, String iconPath,
      {VoidCallback? onTap}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Image.asset('assets/image/$iconPath'),
        ),
        const SizedBox(height: 7),
        Text(label),
      ],
    );
  }

  Widget _buildQuickActions() {
    return const SliverToBoxAdapter(
      child: SizedBox(height: 20),
    );
  }

  Widget _buildLatestTransactions(
    BuildContext context,
    List<TransactionResponse> transactions,
  ) {
    final appLoc = AppLocalizations.of(context)!;
    int topUpCount = 0;
    int transferCount = 0;
    int withdrawCount = 0;

    // Single pass to count transaction types
    for (var transaction in transactions) {
      switch (transaction.type) {
        case 'top_up':
          topUpCount++;
          break;
        case 'transfer':
          transferCount++;
          break;
        case 'withdraw':
          withdrawCount++;
          break;
      }
    }

    // Summary Items
    final List<Map<String, dynamic>> summaries = [
      {
        'title': appLoc.top_ups,
        'count': topUpCount,
        'icon': Icons.account_balance_wallet,
        'color1': const Color(0xFF6DD5FA),
        'color2': const Color(0xFF2980B9),
      },
      {
        'title': appLoc.transfers,
        'count': transferCount,
        'icon': Icons.swap_horiz,
        'color1': const Color(0xFFB993D6),
        'color2': const Color(0xFF8CA6DB),
      },
      {
        'title': appLoc.withdrawals,
        'count': withdrawCount,
        'icon': Icons.arrow_downward_rounded,
        'color1': const Color(0xFFF8C471),
        'color2': const Color(0xFFD35400),
      },
    ];

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appLoc.transaction_overview,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: summaries.length,
              itemBuilder: (context, index) {
                final summary = summaries[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        summary['color1'],
                        summary['color2'],
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: summary['color2'].withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 20),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white.withOpacity(0.15),
                      child: Icon(
                        summary['icon'],
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    title: Text(
                      summary['title'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    trailing: Text(
                      '${summary['count']}',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(title,
          style:
              GoogleFonts.openSans(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}
