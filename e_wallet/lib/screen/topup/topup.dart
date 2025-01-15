import 'package:e_wallet/constant/load_status.dart';
import 'package:e_wallet/constant/utils.dart';
import 'package:e_wallet/repositories/api/api.dart';
import 'package:e_wallet/screen/topup/topup_cubit.dart';
import 'package:e_wallet/screen/topup_success/topup_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant/colours.dart';
import '../../l10n/app_localizations.dart';
import '../history_detail/history_detail.dart';

class TopUpScreen extends StatelessWidget {
  const TopUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TopUpCubit(context.read<Api>())..fetchTransactions(),
      child: _TopUpScreenPage(),
    );
  }
}

class _TopUpScreenPage extends StatelessWidget {
  String selectedMethod = 'Bank Transfer';
  List<double> quickAmounts = [50, 100, 200, 500];

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocConsumer<TopUpCubit, TopUpState>(builder: (context, state) {
        final transactions = state.responses;
        final cubit = context.read<TopUpCubit>();

        if (state.loadStatus == LoadStatus.Loading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appLoc.top_up_amount,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20),

                // Quick Amount Selection
                Wrap(
                  spacing: 12,
                  children: quickAmounts.map((amount) {
                    return ChoiceChip(
                      label: Text(
                        '\$ $amount',
                        style: TextStyle(
                            color: cubit.state.amount == amount.toString()
                                ? theme.colorScheme.onPrimary
                                : theme.textTheme.bodyLarge!.color),
                      ),
                      selected: cubit.state.amount == amount.toString(),
                      selectedColor: Colors.deepPurple,
                      onSelected: (selected) {
                        cubit.updateAmount(amount.toString());
                      },
                    );
                  }).toList(),
                ),

                const SizedBox(height: 20),

                ListTile(
                  leading: const Icon(Icons.account_balance_wallet),
                  title: Text(appLoc.bank_transfer),
                  trailing: Radio<String>(
                    value: 'Bank Transfer',
                    groupValue: selectedMethod,
                    onChanged: (selected) {},
                  ),
                ),

                const SizedBox(height: 30),

                // Top-Up Button
                Center(
                  child: ElevatedButton(
                    onPressed: cubit.state.isButtonEnabled
                        ? () {
                            cubit.topUp();
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: Text(appLoc.top_up_now),
                  ),
                ),

                const SizedBox(height: 40),

                // Transaction List
                Text(
                  appLoc.recent_top_ups,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                state.responses.isEmpty
                    ? Text(appLoc.no_top_ups_yet)
                    : ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height *
                              0.5, // Limit the height
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.responses.length,
                          itemBuilder: (context, index) {
                            final transaction = state.responses[index];

                            final formattedDate =
                                formatCustomDate(context, transaction.date!);
                            return Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HistoryDetail(transaction: transaction),
                                  ),
                                ),
                                child: ListTile(
                                  leading: const Icon(Icons.check_circle,
                                      color: Colors.green),
                                  title: Text('\$${transaction.amount}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color:
                                            transaction.amount.startsWith('-')
                                                ? Colors.redAccent
                                                : Colors.green,
                                      )),
                                  subtitle: Text(appLoc.bank_transfer),
                                  trailing: Text(formattedDate),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
        );
      }, listener: (context, state) {
        if (state.isTopUpSuccess && state.loadStatus == LoadStatus.Done) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TopUpSuccessScreen(
                amount: state.amount,
              ),
            ),
          );
        }
      }),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        appLoc.top_up,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      backgroundColor: btntxt,
    );
  }
}
