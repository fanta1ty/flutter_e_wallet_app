import 'package:e_wallet/constant/load_status.dart';
import 'package:e_wallet/constant/utils.dart';
import 'package:e_wallet/repositories/api/api.dart';
import 'package:e_wallet/screen/withdraw/withdraw_cubit.dart';
import 'package:e_wallet/screen/withdraw_success/withdraw_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant/colours.dart';
import '../../l10n/app_localizations.dart';
import '../history_detail/history_detail.dart';

class WithdrawScreen extends StatelessWidget {
  const WithdrawScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          WithdrawCubit(context.read<Api>())..fetchTransactions(),
      child: _WithdrawPage(),
    );
  }
}

class _WithdrawPage extends StatelessWidget {
  final List<double> quickAmounts = [50, 100, 200, 500];

  _WithdrawPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: BlocConsumer<WithdrawCubit, WithdrawState>(
        builder: (context, state) {
          final cubit = context.read<WithdrawCubit>();

          return state.loadStatus == LoadStatus.Loading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appLoc.withdrawal_amount,
                          style: theme.textTheme.headlineSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildQuickSelect(cubit, theme),
                        const SizedBox(height: 20),
                        _buildCustomAmountInput(cubit, appLoc, theme),
                        const SizedBox(height: 30),
                        _buildWithdrawButton(context, cubit, appLoc),
                        const SizedBox(height: 40),
                        _buildRecentWithdrawals(context, state, appLoc, theme),
                      ],
                    ),
                  ),
                );
        },
        listener: (context, state) {
          if (state.isWithdrawSuccess && state.loadStatus == LoadStatus.Done) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WithdrawSuccessScreen(
                  amount: state.amount,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildQuickSelect(WithdrawCubit cubit, ThemeData theme) {
    return Wrap(
      spacing: 12,
      children: quickAmounts.map((amount) {
        final bool isSelected = cubit.state.amount == amount.toString();
        return ChoiceChip(
          label: Text('\$ $amount'),
          selected: isSelected,
          labelStyle: TextStyle(
            color: isSelected
                ? theme.colorScheme.onPrimary
                : theme.textTheme.bodyLarge!.color,
          ),
          selectedColor: theme.colorScheme.primary,
          backgroundColor: theme.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onSelected: (selected) {
            cubit.updateAmount(amount.toString());
          },
        );
      }).toList(),
    );
  }

  Widget _buildCustomAmountInput(
      WithdrawCubit cubit, AppLocalizations appLoc, ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: TextField(
        onChanged: cubit.updateAmount,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: appLoc.enter_custom_amount,
          prefixIcon: const Icon(Icons.attach_money),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        ),
      ),
    );
  }

  Widget _buildWithdrawButton(
      BuildContext context, WithdrawCubit cubit, AppLocalizations appLoc) {
    final bool isEnabled = cubit.state.isButtonEnabled;
    final theme = Theme.of(context);

    return Center(
      child: ElevatedButton(
        onPressed: isEnabled ? cubit.withdraw : null,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isEnabled ? theme.colorScheme.primary : theme.disabledColor,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(appLoc.withdraw_now),
      ),
    );
  }

  Widget _buildRecentWithdrawals(BuildContext context, WithdrawState state,
      AppLocalizations appLoc, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appLoc.recent_withdrawals,
          style: theme.textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        state.responses.isEmpty
            ? Text(appLoc.no_withdrawals_yet)
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.responses.length,
                itemBuilder: (context, index) {
                  final transaction = state.responses[index];
                  final formattedDate =
                      formatCustomDate(context, transaction.date!);

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HistoryDetail(transaction: transaction),
                        ),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.account_balance_wallet_rounded,
                          color: theme.colorScheme.primary,
                        ),
                        title: Text(
                          '\$${transaction.amount}',
                          style: theme.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(appLoc.bank_transfer),
                        trailing: Text(formattedDate),
                      ),
                    ),
                  );
                },
              ),
      ],
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    return AppBar(
      backgroundColor: btntxt,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(appLoc.withdraw,
          style: const TextStyle(fontSize: 22, color: Colors.white)),
      centerTitle: true,
      elevation: 3,
    );
  }
}
