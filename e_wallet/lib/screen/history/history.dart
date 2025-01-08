import 'dart:math';

import 'package:e_wallet/constant/colours.dart';
import 'package:e_wallet/models/response/transaction_response.dart';
import 'package:e_wallet/repositories/api/api.dart';
import 'package:e_wallet/screen/history/history_cubit.dart';
import 'package:e_wallet/screen/history_detail/history_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../constant/banks.dart';
import '../../constant/load_status.dart';
import '../../constant/utils.dart';
import '../../l10n/app_localizations.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildHistoryList(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        appLoc.transaction_history,
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
    );
  }

  Widget _buildHistoryList(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    return BlocConsumer<HistoryCubit, HistoryState>(
      builder: (context, state) {
        final transactions = state.responses;

        if (state.loadStatus == LoadStatus.Loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (transactions.isEmpty) {
          return Center(
            child: Text(
              appLoc.no_transactions_yet,
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        final groupedTransactions = _groupTransactions(context, transactions);

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          itemCount: groupedTransactions.length,
          itemBuilder: (context, index) {
            final date = groupedTransactions.keys.elementAt(index);
            final types = groupedTransactions[date]!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDateHeader(date),
                ...types.entries.expand((typeEntry) {
                  final type = typeEntry.key;
                  final transactionsByType = typeEntry.value;

                  return [
                    _buildTypeHeader(type),
                    ...transactionsByType.map(
                      (transaction) => GestureDetector(
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
                      ),
                    ),
                  ];
                }),
              ],
            );
          },
        );
      },
      listener: (context, state) {},
    );
  }

  Widget _buildDateHeader(String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        date,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget _buildTypeHeader(String type) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4, left: 5),
      child: Text(
        type,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.deepPurple,
        ),
      ),
    );
  }

  Map<String, Map<String, List<TransactionResponse>>> _groupTransactions(
      BuildContext context, List<TransactionResponse> transactions) {
    Map<String, Map<String, List<TransactionResponse>>> groupedTransactions =
        {};

    for (var transaction in transactions) {
      final parsedDate = DateTime.parse(transaction.bankDate?.isNotEmpty == true
          ? transaction.bankDate!
          : transaction.date!);
      final formattedDate = DateFormat('MMMM dd, yyyy').format(parsedDate);

      final type = _getTransactionType(context, transaction.type);

      groupedTransactions.putIfAbsent(formattedDate, () => {});
      groupedTransactions[formattedDate]!
          .putIfAbsent(type, () => [])
          .add(transaction);
    }
    return groupedTransactions;
  }

  String _getTransactionType(BuildContext context, String type) {
    final appLoc = AppLocalizations.of(context)!;
    switch (type) {
      case 'top_up':
        return appLoc.top_ups;
      case 'transfer':
        return appLoc.transfers;
      case 'withdraw':
        return appLoc.withdrawals;
      default:
        return appLoc.others;
    }
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
    final title = _getTitle();
    final imagePath = _getImagePath();
    final parsedDate = transaction.bankDate?.isNotEmpty == true
        ? transaction.bankDate!
        : transaction.date!;
    final formattedDate = formatCustomDate(context, parsedDate);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(14),
        leading: CircleAvatar(
          backgroundImage: AssetImage(imagePath),
          radius: 28,
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(formattedDate),
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

  String _getTitle() {
    if (transaction.type == 'transfer') {
      return '${fetchBankNameWith(transaction.bankCode)} - ${transaction.to}';
    }
    return transaction.to ?? 'Transaction';
  }

  String _getImagePath() {
    switch (transaction.type) {
      case 'top_up':
        return 'assets/image/topup_icon.png';
      case 'withdraw':
        return 'assets/image/withdraw_icon.png';
      case 'transfer':
        return (transaction.bankDate != null &&
                transaction.bankDate!.isNotEmpty)
            ? fetchBankImageWith(transaction.bankCode)
            : 'assets/image/avatar_${Random().nextInt(4) + 1}.png';
      default:
        return 'assets/image/avatar_${Random().nextInt(4) + 1}.png';
    }
  }
}
