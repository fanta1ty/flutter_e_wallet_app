import 'package:e_wallet/constant/colours.dart';
import 'package:e_wallet/screen/transfer/transfer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Map<String, String>> users = [
    {'name': 'Add New', 'image': 'assets/image/add.png'},
    {'name': 'Thinh Nguyen', 'image': 'assets/image/image1.png'},
  ];

  final List<Map<String, dynamic>> transactions = [
    {
      'title': 'Transfer',
      'date': 'Yesterday · 19:12',
      'amount': -600000,
      'icon': Icons.swap_horiz,
      'color': Colors.red
    },
    {
      'title': 'Top Up',
      'date': 'May 29, 2023 · 19:12',
      'amount': 60000,
      'icon': Icons.account_balance_wallet,
      'color': Colors.green
    },
    {
      'title': 'Internet',
      'date': 'May 16, 2023 · 17:34',
      'amount': -350000,
      'icon': Icons.wifi,
      'color': Colors.red
    },
    {
      'title': 'Work history',
      'date': 'May 13, 2022 · 17:94',
      'amount': 450000,
      'icon': Icons.work_history,
      'color': Colors.green
    },
    {
      'title': 'Bills',
      'date': 'May 13, 2022 · 17:94',
      'amount': -670000,
      'icon': Icons.work_history,
      'color': Colors.red
    },
    {
      'title': 'Balance',
      'date': 'May 13, 2022 · 17:94',
      'amount': 450000,
      'icon': Icons.balance,
      'color': Colors.green
    },
  ];

  String formatAmount(int amount) {
    // Convert amount to currency format
    String formatted = amount.abs().toString().replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+$)'), (Match m) => '${m[1]}.');
    return amount < 0 ? '-\$ $formatted' : '\$ $formatted';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 289,
              color: btntxt,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/image/logo-in.png',
                            height: 30,
                          ),
                          Container(
                            width: 130,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Color(0xFFffa41c),
                                  ),
                                  Text('0 Points')
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Your Balance',
                        style: TextStyle(color: Colors.white, fontSize: 19),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            formatAmount(100),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.remove_red_eye_rounded,
                            color: Colors.white,
                          )
                        ],
                      )
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                              top: Radius.elliptical(300, 40))),
                    ),
                  ),
                  Positioned(
                    top: 200,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withValues(alpha: 0.5),
                                  spreadRadius: 2,
                                  blurRadius: 9,
                                  offset: Offset(0, 3))
                            ],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  child: Image.asset(
                                      'assets/image/transfer 1.png'),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Transfer()));
                                  },
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  'Transfer',
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/image/icon-wtihdraw.png',
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text('Top Up')
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/image/icon-wallet.png'),
                                SizedBox(
                                  height: 7,
                                ),
                                Text('Withdraw')
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/image/icon-more.png'),
                                SizedBox(
                                  height: 7,
                                ),
                                Text('More')
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Send again',
                    style: GoogleFonts.openSans(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        'See all',
                        style: GoogleFonts.openSans(
                            fontSize: 17, color: Color(0xFF059e8c)),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Color(0xFF059e8c),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 150,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(users[index]['image']!),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: index == 0
                            ? Center(
                                child: Icon(Icons.add,
                                    color: Colors.purple, size: 30),
                              )
                            : null, // Add '+' Icon for 'Add New'
                      ),
                      SizedBox(height: 5),
                      Text(users[index]['name']!,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500)),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Latest Transaction',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Text(
                        'See all ',
                        style:
                            TextStyle(fontSize: 17, color: Color(0xFF059e8c)),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Color(0xFF059e8c),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.purple[100],
                    child: Icon(transaction['icon'], color: Colors.purple),
                  ),
                  title: Text(transaction['title'],
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(transaction['date']),
                  trailing: Text(
                    formatAmount(transaction['amount']),
                    style: TextStyle(
                      color: transaction['color'],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      )),
    );
  }
}
