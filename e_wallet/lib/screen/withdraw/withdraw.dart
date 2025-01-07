import 'package:e_wallet/constant/load_status.dart';
import 'package:e_wallet/repositories/api/api.dart';
import 'package:e_wallet/screen/withdraw/withdraw_cubit.dart';
import 'package:e_wallet/screen/withdraw_success/withdraw_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../constant/colours.dart';

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
  List<double> quickAmounts = [50, 100, 200, 500];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocConsumer<WithdrawCubit, WithdrawState>(
        builder: (context, state) {
          final transactions = state.responses;
          final cubit = context.read<WithdrawCubit>();

          return state.loadStatus == LoadStatus.Loading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Withdrawal Amount',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 20),

                        // Quick Select Amounts
                        Wrap(
                          spacing: 12,
                          children: quickAmounts.map((amount) {
                            return ChoiceChip(
                              label: Text('\$ $amount'),
                              selected: cubit.state.amount == amount.toString(),
                              selectedColor: Colors.deepPurple,
                              onSelected: (selected) {
                                cubit.updateAmount(amount.toString());
                              },
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 20),

                        // Custom Amount Input
                        TextField(
                          onChanged: cubit.updateAmount,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Enter custom amount',
                            prefixIcon: const Icon(Icons.attach_money),
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  color: Colors.purple, width: 2),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Withdraw Button
                        Center(
                          child: ElevatedButton(
                            onPressed: cubit.state.isButtonEnabled
                                ? () {
                                    cubit.withdraw();
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: const Text('Withdraw Now'),
                          ),
                        ),

                        const SizedBox(height: 40),

                        // Transaction List
                        const Text(
                          'Recent Withdrawals',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 10),
                        state.responses.isEmpty
                            ? const Text('No withdrawals yet.')
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.responses.length,
                                itemBuilder: (context, index) {
                                  final transaction = state.responses[index];
                                  final parsedDate =
                                      DateTime.parse(transaction.date ?? "");
                                  final formattedDate =
                                      DateFormat('MMMM dd, yyyy - hh:mm a')
                                          .format(parsedDate);
                                  return Card(
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: ListTile(
                                      leading: const Icon(Icons.check_circle,
                                          color: Colors.green),
                                      title: Text('\$${transaction.amount}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: transaction.amount
                                                    .startsWith('-')
                                                ? Colors.redAccent
                                                : Colors.green,
                                          )),
                                      subtitle: Text('Bank Transfer'),
                                      trailing: Text(formattedDate),
                                    ),
                                  );
                                },
                              ),
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

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const Text(
        'Withdraw',
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
}
