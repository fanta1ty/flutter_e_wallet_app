import 'dart:math';

import 'package:e_wallet/constant/utils.dart';
import 'package:e_wallet/models/request/transfer_request.dart';
import 'package:e_wallet/screen/submited_to_friend/submited_to_friend_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../constant/colours.dart';
import '../nabbar/nabbar.dart';

class SubmitedToFriend extends StatelessWidget {
  final TransferRequest request;

  const SubmitedToFriend({required this.request, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubmitedToFriendCubit(),
      child: _SubmitedToFriendPage(
        request: request,
      ),
    );
  }
}

class _SubmitedToFriendPage extends StatelessWidget {
  final TransferRequest request;

  const _SubmitedToFriendPage({required this.request, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        DateFormat('MMMM d, yyyy').format(DateTime.parse(request.date));
    final formattedTime =
        DateFormat('hh:mm a').format(DateTime.parse(request.date));

    // Parse the amount to double
    final double parsedAmount = double.tryParse(request.amount) ?? 0.0;
    final double totalPayment = parsedAmount + 2.0;
    final imagePath = 'assets/image/avatar_${Random().nextInt(4) + 1}.png';

    return Scaffold(
      backgroundColor: btntxt,
      body: BlocConsumer<SubmitedToFriendCubit, SubmitedToFriendState>(
        builder: (context, state) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/image/icon1.png'),
                  const SizedBox(height: 20),
                  _buildTransactionCard(parsedAmount, totalPayment,
                      formattedDate, formattedTime, imagePath, context),
                  const SizedBox(height: 30),
                  _buildButtons(context),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }

  Widget _buildTransactionCard(double amount, double totalPayment, String date,
      String time, String imagePath, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      constraints: const BoxConstraints(maxWidth: 400),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        children: [
          const Text(
            "Transfer Successful",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xFF04ba62)),
          ),
          const SizedBox(height: 5),
          const Text("Your transaction was successful"),
          const SizedBox(height: 20),
          Text(
            '\$ ${amount.toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(imagePath),
            ),
            title: Text(formattedPhone(request.phone),
                style: const TextStyle(color: Colors.blueAccent)),
            subtitle: Text(request.to,
                style: const TextStyle(color: Colors.pinkAccent)),
          ),
          const Divider(),
          _buildTransactionDetailRow(
              "Payment", '\$ ${amount.toStringAsFixed(2)}'),
          _buildTransactionDetailRow("Date", date),
          _buildTransactionDetailRow("Time", time),
          _buildTransactionDetailRow("Reference Number", "QOIU-0012-ADFE-2234"),
          _buildTransactionDetailRow("Fee", "\$ 2.0"),
          const Divider(),
          _buildTransactionDetailRow(
              "Total Payment", '\$ ${totalPayment.toStringAsFixed(2)}',
              isBold: true, color: btntxt, fontSize: 18),
        ],
      ),
    );
  }

  Widget _buildTransactionDetailRow(String label, String value,
      {bool isBold = false, Color color = Colors.black, double fontSize = 14}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:
                  TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500)),
          Text(
            value,
            style: TextStyle(
                fontSize: fontSize,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: btn,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 130),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
          child: const Text('Share', style: TextStyle(color: Colors.white)),
        ),
        const SizedBox(height: 15),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Nabbar()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 100),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
          child: const Text('Back to Home', style: TextStyle(color: btntxt)),
        ),
      ],
    );
  }
}
