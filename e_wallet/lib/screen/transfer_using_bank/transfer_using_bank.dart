import 'package:e_wallet/screen/transfer_to_banks/transfer_to_banks.dart';
import 'package:e_wallet/screen/transfer_using_bank/transfer_using_bank_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant/colours.dart';
import '../../constant/load_status.dart';

class TransferUsingBank extends StatelessWidget {
  TransferUsingBank({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransferUsingBankCubit(),
      child: _TransferUsingBankPage(),
    );
  }
}

class _TransferUsingBankPage extends StatelessWidget {
  String _phone = "";
  String _notes = "";
  String _amount = "";

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<TransferUsingBankCubit, TransferUsingBankState>(
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
                          builder: (context) => TransferToBanks(),
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
                    "Transfer through Bank",
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
                body: SingleChildScrollView(
                  child: Container(
                      width: _screenWidth,
                      color: btntxt,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text("Your Balance",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.white)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "\$ 24.321.900",
                                      style: TextStyle(
                                          fontSize: 23, color: Colors.white),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 100,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.wallet,
                                        color: btntxt,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Top Up",
                                        style: TextStyle(
                                            color: btntxt,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    topLeft: Radius.circular(30))),
                            margin: EdgeInsets.only(top: 20),
                            child: Column(children: [
                              SizedBox(
                                height: 30,
                              ),
                              ListTile(
                                leading: CircleAvatar(
                                  radius: 26,
                                  backgroundImage:
                                      AssetImage('assets/image/bank_1.png'),
                                ),
                                title: Text("Nguyen Van A"),
                                subtitle: Text("••••• •••• 80901"),
                                trailing: Icon(
                                  Icons.edit_note,
                                  size: 30,
                                  color: btn,
                                ),
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //     builder: (context) => ContactToTranfer()));
                                },
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 40),
                                    child: Text(
                                      "Set Amount",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '\$',
                                        style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        width: 60,
                                        child: TextField(
                                          style: TextStyle(
                                              fontSize: 32,
                                              fontWeight: FontWeight.bold),
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          onChanged: (value) {
                                            _amount = value;

                                            final isEnabled =
                                                _amount.isNotEmpty &&
                                                    double.tryParse(_amount) !=
                                                        null;
                                            context
                                                .read<TransferUsingBankCubit>()
                                                .setButtonEnabled(isEnabled);
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 60, left: 20),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Notes",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "(Optional)",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 320,
                                    child: TextField(
                                      onChanged: (value) => _notes = value,
                                      decoration: InputDecoration(
                                        hintText: "Payment for Lunch",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        fillColor: Colors.grey[100],
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide.none,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color:
                                                btn, // Border color when focused
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                      maxLines: 3,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 60,
                                  ),
                                  ElevatedButton(
                                    onPressed: context
                                            .watch<TransferUsingBankCubit>()
                                            .state
                                            .isButtonEnabled
                                        ? () {
                                            context
                                                .read<TransferUsingBankCubit>()
                                                .checkIsProceedToTransfer(
                                                  true,
                                                );
                                          }
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: context
                                              .watch<TransferUsingBankCubit>()
                                              .state
                                              .isButtonEnabled
                                          ? btntxt
                                          : Colors.grey,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 90),
                                    ),
                                    child: Text(
                                      'Proceed to Transfer',
                                      style: TextStyle(
                                        color: context
                                                .watch<TransferUsingBankCubit>()
                                                .state
                                                .isButtonEnabled
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        ],
                      )),
                ),
              );
      },
      listener: (context, state) {},
    );
  }
}
