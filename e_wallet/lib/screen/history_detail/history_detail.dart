import 'package:e_wallet/models/response/transaction_response.dart';
import 'package:e_wallet/screen/history_detail/history_detail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/utils.dart';
import '../../l10n/app_localizations.dart';

class HistoryDetail extends StatelessWidget {
  final TransactionResponse transaction;

  const HistoryDetail({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryDetailCubit(),
      child: _HistoryDetailPage(
        transaction: transaction,
      ),
    );
  }
}

class _HistoryDetailPage extends StatelessWidget {
  final TransactionResponse transaction;

  const _HistoryDetailPage({super.key, required this.transaction});

  Widget _buildDetailRow(String label, String value, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          if (icon != null)
            CircleAvatar(
              backgroundColor: Colors.purple[100],
              radius: 24,
              child: Icon(icon, color: Colors.purple[600], size: 26),
            ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: GoogleFonts.openSans(
                      fontSize: 14,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    )),
                const SizedBox(height: 5),
                Text(value,
                    style: GoogleFonts.openSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(BuildContext context, String dateString) {
    final appLoc = AppLocalizations.of(context)!;
    try {
      return formatCustomDate(context, dateString);
    } catch (e) {
      return appLoc.invalid_date;
    }
  }

  void _shareTransaction(
      BuildContext context, TransactionResponse transaction) {
    final appLoc = AppLocalizations.of(context)!;
    final shareText = '''
${appLoc.transaction_detail}:
${appLoc.to}: ${transaction.to}
${appLoc.amount}: ${formatAmount(transaction.amount)}
${appLoc.date}: ${_formatDate(context, transaction.bankDate?.isNotEmpty == true ? transaction.bankDate! : transaction.date!)}
${appLoc.from}: ${transaction.from}
''';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${appLoc.shared}: \n$shareText")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    return BlocConsumer<HistoryDetailCubit, HistoryDetailState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              appLoc.transaction_detail,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.deepPurple,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 15,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow("${appLoc.to}:", transaction.to,
                        icon: Icons.person_outline),
                    _buildDetailRow(
                        "${appLoc.amount}:", formatAmount(transaction.amount),
                        icon: Icons.attach_money),
                    _buildDetailRow(
                        "${appLoc.date}:",
                        _formatDate(
                            context,
                            transaction.bankDate?.isNotEmpty == true
                                ? transaction.bankDate!
                                : transaction.date!),
                        icon: Icons.calendar_today),
                    _buildDetailRow("${appLoc.from}:", transaction.from,
                        icon: Icons.account_circle_outlined),
                    _buildDetailRow(
                        "${appLoc.note}:",
                        transaction.note.isEmpty
                            ? appLoc.no_note
                            : transaction.note,
                        icon: Icons.edit_note),
                    const SizedBox(height: 40),
                    Center(
                      child: ElevatedButton.icon(
                        icon: const Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                        label: Text(appLoc.share_transaction),
                        onPressed: () {
                          _shareTransaction(context, transaction);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
