import 'package:e_wallet/screen/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/colours.dart';
import '../transfer/transfer.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: const _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage({super.key});

  static const List<Map<String, String>> users = [
    {'name': 'Add New', 'image': 'assets/image/add.png'},
    {'name': 'Thinh Nguyen', 'image': 'assets/image/image1.png'},
  ];

  static const List<Map<String, dynamic>> transactions = [
    {
      'title': 'Transfer',
      'date': 'Yesterday · 19:12',
      'amount': -600000,
      'icon': Icons.swap_horiz,
      'color': Colors.red
    },
    {
      'title': 'Top Up',
      'date': 'May 29, 2023 · 19:12',
      'amount': 60000,
      'icon': Icons.account_balance_wallet,
      'color': Colors.green
    },
    {
      'title': 'Internet',
      'date': 'May 16, 2023 · 17:34',
      'amount': -350000,
      'icon': Icons.wifi,
      'color': Colors.red
    },
    {
      'title': 'Work history',
      'date': 'May 13, 2022 · 17:94',
      'amount': 450000,
      'icon': Icons.work_history,
      'color': Colors.green
    },
  ];

  String formatAmount(int amount) {
    String formatted = amount.abs().toString().replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+$)'), (Match m) => '${m[1]}.');
    return amount < 0 ? '-\$ $formatted' : '\$ $formatted';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(
        builder: (context, state) {
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                _buildHeader(context),
                _buildQuickActions(),
                _buildSendAgainSection(),
                _buildLatestTransactions(),
              ],
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
                  _buildPointsBadge(),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Your Balance',
                    style: TextStyle(color: Colors.white, fontSize: 19)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(formatAmount(100),
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

  Widget _buildPointsBadge() {
    return Container(
      width: 130,
      height: 40,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: const Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star, color: Color(0xFFffa41c)),
            Text('0 Points')
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
            _buildActionItem(context, 'Transfer', 'transfer 1.png',
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Transfer()))),
            _buildActionItem(context, 'Top Up', 'icon-wtihdraw.png'),
            _buildActionItem(context, 'Withdraw', 'icon-wallet.png'),
            _buildActionItem(context, 'More', 'icon-more.png'),
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

  Widget _buildSendAgainSection() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('Send again'),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(users[index]['image']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: index == 0
                          ? const Center(
                              child: Icon(Icons.add,
                                  color: Colors.purple, size: 30),
                            )
                          : null,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      users[index]['name']!,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLatestTransactions() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final transaction = transactions[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.purple[100],
            child: Icon(transaction['icon'], color: Colors.purple),
          ),
          title: Text(transaction['title'],
              style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(transaction['date']),
          trailing: Text(formatAmount(transaction['amount']),
              style: TextStyle(
                  color: transaction['color'], fontWeight: FontWeight.bold)),
        );
      }, childCount: transactions.length),
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
