import 'package:e_wallet/screen/transfer_to_bank/transfer_to_bank.dart';
import 'package:e_wallet/screen/transfer_to_banks/transfer_to_banks_cubit.dart';
import 'package:e_wallet/screen/transfer_using_bank/transfer_using_bank.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant/colours.dart';
import '../../constant/load_status.dart';

class TransferToBanks extends StatelessWidget {
  TransferToBanks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransferToBanksCubit(),
      child: _TransferToBanksPage(),
    );
  }
}

class _TransferToBanksPage extends StatelessWidget {
  String _seach = "";
  final List<Map<String, String>> contacts = [
    {"name": "Bank Central Asia (BCA)", "image": "assets/image/bank_1.png"},
    {"name": "Bank Negara Indonesia (BNI)", "image": "assets/image/bank_2.png"},
    {"name": "Bank Rakyat Indonesia (BRI)", "image": "assets/image/bank_3.png"},
    {"name": "Bank Tabungan Negara (BTN)", "image": "assets/image/bank_4.png"},
    {"name": "Bank Mandiri", "image": "assets/image/bank_5.png"},
    {
      "name": "Bank Artha Graha Internasional",
      "image": "assets/image/bank_6.png"
    },
    {"name": "Bank CIMB Niaga", "image": "assets/image/bank_7.png"},
    {"name": "Bank Danamon Indonesia", "image": "assets/image/bank_8.png"},
    {"name": "Bank Maybank Indonesia", "image": "assets/image/bank_9.png"},
  ];

  _TransferToBanksPage({super.key});

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<TransferToBanksCubit, TransferToBanksState>(
      builder: (context, state) {
        return state.loadStatus == LoadStatus.Loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                appBar: AppBar(
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TransferToBank(),
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
                    "Transfer to Bank",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  )),
                  backgroundColor: btntxt,
                  actions: [
                    Image(image: AssetImage('assets/image/help.png')),
                    SizedBox(
                      width: 30,
                    )
                  ],
                ),
                body: Container(
                  width: _screenWidth,
                  height: _screenHeight,
                  color: btntxt,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30))),
                    margin: EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 30),
                          child: Row(
                            children: [
                              Container(
                                width: 340,
                                child: TextField(
                                  onChanged: (value) => _seach = value,
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(Icons.search),
                                      hintText: "Search Phone Number",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30, left: 20),
                          child: Text(
                            "All Contact",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: contacts.length,
                            itemBuilder: (context, index) {
                              final contact = contacts[index];
                              return ListTile(
                                leading: CircleAvatar(
                                  radius: 24,
                                  backgroundImage:
                                      AssetImage(contact['image']!),
                                ),
                                title: Text(contact['name']!),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 17,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TransferUsingBank(),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
      },
      listener: (context, state) {},
    );
  }
}
