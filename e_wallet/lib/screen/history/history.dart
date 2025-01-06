import 'dart:math';

import 'package:e_wallet/constant/colours.dart';
import 'package:e_wallet/constant/utils.dart';
import 'package:e_wallet/models/response/transaction_response.dart';
import 'package:e_wallet/repositories/api/api.dart';
import 'package:e_wallet/screen/history/history_cubit.dart';
import 'package:e_wallet/screen/history_detail/history_detail.dart';
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
        title: const Text(
          'Transaction History',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [btntxt, Colors.deepPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 2,
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
            : transactions.isEmpty
                ? const Center(
                    child: Text(
                      'No transactions yet',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 16),
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = transactions[index];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HistoryDetail(transaction: transaction),
                          ),
                        ),
                        child: _TransactionItem(
                          transaction: transaction,
                          formatAmount: formatAmount,
                        ),
                      );
                    },
                  );
      },
      listener: (context, state) {},
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final TransactionResponse transaction;
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
