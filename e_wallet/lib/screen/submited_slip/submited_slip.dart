import 'package:e_wallet/constant/banks.dart';
import 'package:e_wallet/constant/utils.dart';
import 'package:e_wallet/models/request/transfer_request.dart';
import 'package:e_wallet/screen/submited_slip/submited_slip_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../constant/colours.dart';
import '../../l10n/app_localizations.dart';
import '../nabbar/nabbar.dart';

class SubmitedSlip extends StatelessWidget {
  final TransferRequest request;

  const SubmitedSlip({required this.request, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubmitedSlipCubit(),
      child: _SubmitedSlipPage(
        request: request,
      ),
    );
  }
}

class _SubmitedSlipPage extends StatelessWidget {
  final TransferRequest request;

  const _SubmitedSlipPage({required this.request, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    final formattedDate =
        formatCustomDate2(context, request.bankDate, 'MMMM d, yyyy');
    final formattedTime =
        DateFormat('hh:mm a').format(DateTime.parse(request.bankDate));
    final double parsedAmount = double.tryParse(request.amount) ?? 0.0;
    final double totalPayment = parsedAmount + 2.0;

    return Scaffold(
      backgroundColor: btntxt,
      body: BlocConsumer<SubmitedSlipCubit, SubmitedSlipState>(
        builder: (context, state) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/image/icon1.png'),
                    Center(
                      child: Container(
                        width: constraints.maxWidth * 0.85,
                        margin: const EdgeInsets.symmetric(vertical: 20),
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
                            Text(
                              appLoc.transfer_successful,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color(0xFF04ba62),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              appLoc.your_transaction_was_successful,
                              style: TextStyle(fontSize: 15),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              '\$ ${parsedAmount.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                            const SizedBox(height: 15),
                            ListTile(
                              leading: CircleAvatar(
                                radius: 28,
                                backgroundImage: AssetImage(fetchBankImageWith(
                                  request.bankCode,
                                )),
                              ),
                              title: Text(
                                request.to,
                                style: const TextStyle(fontSize: 16),
                              ),
                              subtitle: const Text("••••• •••• 80901"),
                            ),
                            const Divider(),
                            _buildTransactionDetails(appLoc.payment,
                                '\$ ${parsedAmount.toStringAsFixed(2)}'),
                            _buildTransactionDetails(
                                appLoc.date, formattedDate),
                            _buildTransactionDetails(
                                appLoc.time, formattedTime),
                            _buildTransactionDetails(
                                appLoc.reference_number, "ALKS-9928-HGJD-1134"),
                            _buildTransactionDetails(appLoc.fee, "\$ 2.0"),
                            const Divider(),
                            _buildTransactionDetails(
                              appLoc.total_payment,
                              '\$ ${totalPayment.toStringAsFixed(2)}',
                              isBold: true,
                              color: btntxt,
                              fontSize: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                    _buildButton(
                      context,
                      label: appLoc.share,
                      onPressed: () {},
                      backgroundColor: btn,
                      textColor: Colors.white,
                    ),
                    const SizedBox(height: 10),
                    _buildButton(
                      context,
                      label: appLoc.back_to_home,
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Nabbar()),
                        );
                      },
                      backgroundColor: Colors.white,
                      textColor: btntxt,
                    ),
                  ],
                ),
              );
            },
          );
        },
        listener: (context, state) {},
      ),
    );
  }

  Widget _buildTransactionDetails(String label, String value,
      {bool isBold = false, Color color = Colors.black, double fontSize = 14}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required String label,
    required VoidCallback onPressed,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 120),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(color: textColor, fontSize: 16),
      ),
    );
  }
}
