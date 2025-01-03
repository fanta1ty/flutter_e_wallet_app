import 'package:e_wallet/screen/submited_slip/submited_slip_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../constant/colours.dart';
import '../nabbar/nabbar.dart';

class SubmitedSlip extends StatelessWidget {
  final String amount;

  const SubmitedSlip({required this.amount, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubmitedSlipCubit(),
      child: _SubmitedSlipPage(
        amount: amount,
      ),
    );
  }
}

class _SubmitedSlipPage extends StatelessWidget {
  final String amount;

  _SubmitedSlipPage({required this.amount, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentDateTime = DateTime.now();
    final formattedDate = DateFormat('MMMM d, yyyy').format(currentDateTime);
    final formattedTime = DateFormat('hh:mm a').format(currentDateTime);
    final double parsedAmount = double.tryParse(amount) ?? 0.0;
    final double totalPayment = parsedAmount + 2.0;

    return BlocConsumer<SubmitedSlipCubit, SubmitedSlipState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: btntxt,
          body: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/image/icon1.png'),
                Center(
                  child: Container(
                    width: 320,
                    height: 450,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          "Transfer Successful",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Color(0xFF04ba62),
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text("Your transaction was successful"),
                        const SizedBox(height: 20),
                        Text(
                          'Rp ${parsedAmount.toStringAsFixed(2)}',
                          // Display formatted amount
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: ListTile(
                            leading: const CircleAvatar(
                              radius: 26,
                              backgroundImage:
                                  AssetImage('assets/image/bank_1.jpg'),
                            ),
                            title: const Text("Nguyen Van A"),
                            subtitle: const Text("••••• •••• 80901"),
                          ),
                        ),
                        const Text(
                          "Transaction Details",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Payment",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'Rp ${parsedAmount.toStringAsFixed(2)}',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Date",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                formattedDate,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Time",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                formattedTime,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Reference Number",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "ALKS-9928-HGJD-1134",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Fee",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "\$ 2.0",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Total Payment",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: btntxt),
                              ),
                              Text(
                                'Rp ${totalPayment.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontSize: 18, color: btntxt),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Share',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: btn,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 130),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                      // Adjust the radius as needed
                      side: const BorderSide(
                          color: Colors.white, width: 2), // White border
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Nabbar()));
                  },
                  child: const Text('Back to Home',
                      style: TextStyle(color: btntxt)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 100),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
