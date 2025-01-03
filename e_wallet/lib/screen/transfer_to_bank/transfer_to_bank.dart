import 'package:e_wallet/models/request/transfer_request.dart';
import 'package:e_wallet/screen/submited_slip/submited_slip.dart';
import 'package:e_wallet/screen/transfer/transfer.dart';
import 'package:e_wallet/screen/transfer_to_bank/transfer_to_bank_cubit.dart';
import 'package:e_wallet/screen/transfer_to_banks/transfer_to_banks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant/colours.dart';
import '../../constant/load_status.dart';
import '../../repositories/api/api.dart';

class TransferToBank extends StatelessWidget {
  TransferToBank({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransferToBankCubit(
        context.read<Api>(),
      ),
      child: _TransferToBankPage(),
    );
  }
}

class _TransferToBankPage extends StatelessWidget {
  String _amount = "";
  String _notes = "";
  String _code = "";
  String _to = "";
  String _date = "";

  _TransferToBankPage({super.key});

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<TransferToBankCubit, TransferToBankState>(
      builder: (context, state) {
        return state.loadStatus == LoadStatus.Loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                appBar: AppBar(
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Transfer()));
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ),
                  title: Center(
                      child: Text(
                    "Transfer to Bank",
                    style: TextStyle(color: Colors.white),
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
                          width: _screenWidth,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  topLeft: Radius.circular(30))),
                          margin: EdgeInsets.only(top: 30),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                      top: 20,
                                      left: 20,
                                    ),
                                    width: 350,
                                    child: TextField(
                                      onChanged: (value) => _code = value,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      TransferToBanks(),
                                                ),
                                              );
                                            },
                                            icon: Icon(
                                                Icons.keyboard_arrow_down)),
                                        hintText: "Bank code",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                          top: 20,
                                          left: 20,
                                        ),
                                        width: 300,
                                        child: TextField(
                                          onChanged: (value) => _to = value,
                                          keyboardType: TextInputType.name,
                                          decoration: InputDecoration(
                                            hintText: "To",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
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
                                                .read<TransferToBankCubit>()
                                                .setButtonEnabled(isEnabled);
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 80, left: 20),
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
                                        hintText: "Write your notes here",
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
                                            .watch<TransferToBankCubit>()
                                            .state
                                            .isButtonEnabled
                                        ? () {
                                            _date = DateTime.now()
                                                .toIso8601String();
                                            context
                                                .read<TransferToBankCubit>()
                                                .transfer(
                                                  _amount,
                                                  _notes,
                                                  '',
                                                  '',
                                                  _date,
                                                  _code.toLowerCase(),
                                                  _to,
                                                  'thnu',
                                                );
                                          }
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: context
                                              .watch<TransferToBankCubit>()
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
                                                .watch<TransferToBankCubit>()
                                                .state
                                                .isButtonEnabled
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
      },
      listener: (context, state) {
        if (state.isTransferSuccess && state.loadStatus == LoadStatus.Done) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SubmitedSlip(
                request: TransferRequest(
                  amount: _amount,
                  note: _notes,
                  phone: '',
                  date: '',
                  bankDate: _date,
                  bankCode: _code.toLowerCase(),
                  to: _to,
                  from: 'thnu',
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
