import 'dart:math';

import 'package:e_wallet/constant/colours.dart';
import 'package:e_wallet/constant/utils.dart';
import 'package:e_wallet/repositories/api/api.dart';
import 'package:e_wallet/screen/history/history_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../constant/banks.dart';
import '../../constant/load_status.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HistoryCubit(context.read<Api>())..fetchTransactions(),
      child: const _HistoryPage(),
    );
  }
}

class _HistoryPage extends StatelessWidget {
  const _HistoryPage({super.key});

  String formatAmount(String amount) {
    return '\$ ${amount.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+\$)'),
      (Match m) => '${m[1]}.',
    )}';
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('History', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: btntxt,
        elevation: 0,
      ),
      body: _buildHistoryList(context),
    );
  }

  Widget _buildHistoryList(BuildContext context) {
    return BlocConsumer<HistoryCubit, HistoryState>(
      builder: (context, state) {
        final transactions = state.responses;

        return state.loadStatus == LoadStatus.Loading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return _TransactionItem(
                    transaction: transaction,
                    formatAmount: formatAmount,
                  );
                },
              );
      },
      listener: (context, state) {},
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
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(imagePath),
          radius: 25,
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(formattedDate),
        trailing: Text(
          formatAmount(transaction.amount),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
