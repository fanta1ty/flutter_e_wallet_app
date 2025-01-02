import 'package:e_wallet/constant/colours.dart';
import 'package:e_wallet/screen/home/home.dart';
import 'package:e_wallet/screen/transfer/transfer_cubit.dart';
import 'package:e_wallet/screen/transfer_to_friend/transfer_to_friend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Transfer extends StatelessWidget {
  const Transfer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransferCubit(),
      child: TransferPage(),
    );
  }
}

class TransferPage extends StatelessWidget {
  final List<Map<String, dynamic>> transactions = [
    {
      'name': 'VCB - Thinh Nguyen',
      'date': 'Dec 31, 2024 · 21:54',
      'amount': 745000,
      'image': 'assets/image/Frame 3.png',
    },
    {
      'name': 'Techcombank - Thinh Nguyen',
      'date': 'Jan 1, 2025 · 04:18',
      'amount': 450000,
      'image': 'assets/image/Frame 3 (1).png',
    },
    {
      'name': 'VietinBank - Thinh Nguyen',
      'date': 'Jan 2, 2025 · 04:18',
      'amount': 450000,
      'image': 'assets/image/Frame 3 (2).png',
    },
  ];

  TransferPage({super.key});

  String formatAmount(int amount) {
    // Format the amount to Indonesian Rupiah format
    return '\$ ${amount.toString().replaceAllMapped(
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
                builder: (context) => Home(),
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
          return SingleChildScrollView(
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
                                    builder: (context) => TransferToFriend()),
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
                                mainAxisAlignment: MainAxisAlignment.center,
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
                            onTap: () {},
                            child: Container(
                              width: 150,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Color(0xFFf9f5ff),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(transaction['image']),
                            radius: 25,
                          ),
                          title: Text(
                            transaction['name'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(transaction['date']),
                          trailing: Text(
                            formatAmount(transaction['amount']),
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
