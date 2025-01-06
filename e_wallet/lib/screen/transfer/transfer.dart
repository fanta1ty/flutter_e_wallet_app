import 'dart:math';

import 'package:e_wallet/constant/colours.dart';
import 'package:e_wallet/constant/utils.dart';
import 'package:e_wallet/repositories/api/api.dart';
import 'package:e_wallet/screen/transfer/transfer_cubit.dart';
import 'package:e_wallet/screen/transfer_to_bank/transfer_to_bank.dart';
import 'package:e_wallet/screen/transfer_to_friend/transfer_to_friend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../constant/banks.dart';
import '../../constant/load_status.dart';

class Transfer extends StatelessWidget {
  const Transfer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TransferCubit(context.read<Api>())..fetchTransactions(),
      child: const _TransferPage(),
    );
  }
}

class _TransferPage extends StatelessWidget {
  const _TransferPage({super.key});

  String formatAmount(String amount) {
    return '\$ ${amount.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+$)'),
      (Match m) => '${m[1]}.',
    )}';
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocConsumer<TransferCubit, TransferState>(
        builder: (context, state) {
          final transactions = state.responses;

          return state.loadStatus == LoadStatus.Loading
              ? const Center(child: CircularProgressIndicator())
              : Container(
                  height: screenHeight,
                  color: btntxt,
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      _buildTransferOptions(context),
                      const SizedBox(height: 20),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Latest Transfer",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16),
                                  itemCount: transactions.length,
                                  itemBuilder: (context, index) {
                                    final transaction = transactions[index];
                                    return _TransactionItem(
                                      transaction: transaction,
                                      formatAmount: formatAmount,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        },
        listener: (context, state) {},
      ),
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
        'Transfer',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      backgroundColor: btntxt,
      actions: [
        Image.asset('assets/image/help.png'),
        const SizedBox(width: 30),
      ],
    );
  }

  Widget _buildTransferOptions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _TransferOption(
          icon: Icons.people,
          label: 'To Friends',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TransferToFriend()),
            );
          },
        ),
        _TransferOption(
          icon: Icons.account_balance,
          label: 'To Bank',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TransferToBank()),
            );
          },
        ),
      ],
    );
  }
}

class _TransferOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _TransferOption({
    required this.icon,
    required this.label,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 100,
        decoration: BoxDecoration(
          color: const Color(0xFFf9f5ff),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: btntxt, size: 50),
            const SizedBox(height: 10),
            Text(label),
          ],
        ),
      ),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final dynamic transaction;
  final String Function(String) formatAmount;

  const _TransactionItem({
    required this.transaction,
    required this.formatAmount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String title;
    String imagePath;
    String transactionDate;

    if (transaction.bankDate != null && transaction.bankDate!.isNotEmpty) {
      title = '${fetchBankNameWith(transaction.bankCode)} - ${transaction.to}';
      imagePath = fetchBankImageWith(transaction.bankCode);
      transactionDate = transaction.bankDate!;
    } else {
      title = '${formattedPhone(transaction.phone)} - ${transaction.to}';
      transactionDate = transaction.date!;
      imagePath = 'assets/image/avatar_${Random().nextInt(4) + 1}.png';
    }

    final parsedDate = DateTime.parse(transactionDate);
    final formattedDate =
        DateFormat('MMMM dd, yyyy - hh:mm a').format(parsedDate);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          backgroundImage: AssetImage(imagePath),
          radius: 30,
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          formattedDate,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        trailing: Text(
          formatAmount(transaction.amount),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: transaction.amount.startsWith('-')
                ? Colors.redAccent
                : Colors.green,
          ),
        ),
      ),
    );
  }
}
