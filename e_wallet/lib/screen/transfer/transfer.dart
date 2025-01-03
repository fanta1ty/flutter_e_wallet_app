import 'dart:math';

import 'package:e_wallet/constant/colours.dart';
import 'package:e_wallet/constant/utils.dart';
import 'package:e_wallet/repositories/api/api.dart';
import 'package:e_wallet/screen/nabbar/nabbar.dart';
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
      child: _TransferPage(),
    );
  }
}

class _TransferPage extends StatelessWidget {
  _TransferPage();

  String formatAmount(String amount) {
    // Format the amount to Indonesian Rupiah format
    return '\$ ${amount.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+$)'),
      (Match m) => '${m[1]}.',
    )}';
  }

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Nabbar(),
              ),
            );
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        title: Center(
          child: Text(
            'Transfer',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: btntxt,
        actions: [
          Image.asset('assets/image/help.png'),
          SizedBox(
            width: 30,
          ),
        ],
      ),
      body: BlocConsumer<TransferCubit, TransferState>(
        builder: (context, state) {
          final transactions = context.watch<TransferCubit>().state.responses;

          return state.loadStatus == LoadStatus.Loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Container(
                    width: _screenWidth,
                    height: _screenHeight,
                    color: btntxt,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                      ),
                      margin: const EdgeInsets.only(
                        top: 30,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 5,
                                  top: 30,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            TransferToFriend(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFf9f5ff),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Icon(
                                            Icons.account_balance,
                                            color: btntxt,
                                            size: 50,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Transfer to Friends',
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  top: 30,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TransferToBank(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFf9f5ff),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Icon(
                                            Icons.account_balance,
                                            color: btntxt,
                                            size: 50,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Transfer to Bank',
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30, left: 10),
                            child: Text(
                              "Latest Transfer",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: transactions.length,
                            itemBuilder: (context, index) {
                              final transaction = transactions[index];
                              String title = '';
                              String imagePath = '';
                              String transactionDate = '';

                              if (transaction.bankDate != null &&
                                  transaction.bankDate!.isNotEmpty) {
                                title =
                                    '${fetchBankNameWith(transaction.bankCode)} - ${transaction.to}';
                                imagePath =
                                    fetchBankImageWith(transaction.bankCode);
                                transactionDate = transaction.bankDate!;
                              } else {
                                title = formattedPhone(transaction.phone);
                                transactionDate = transaction.date!;
                                imagePath =
                                    'assets/image/avatar_${Random().nextInt(4) + 1}.png';
                              }

                              final parsedDate =
                                  DateTime.parse(transactionDate);
                              final formatedTransactionDate =
                                  DateFormat('MMMM dd, yyyy - hh:mm a')
                                      .format(parsedDate);

                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: AssetImage(imagePath),
                                  radius: 25,
                                ),
                                title: Text(
                                  title,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  formatedTransactionDate,
                                ),
                                trailing: Text(
                                  formatAmount(transaction.amount),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        },
        listener: (context, state) {},
      ),
    );
  }
}
