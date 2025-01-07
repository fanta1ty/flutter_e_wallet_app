import 'package:e_wallet/constant/banks.dart';
import 'package:e_wallet/constant/utils.dart';
import 'package:e_wallet/models/request/transfer_request.dart';
import 'package:e_wallet/screen/submited_slip/submited_slip.dart';
import 'package:e_wallet/screen/transfer_using_bank/transfer_using_bank_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant/colours.dart';
import '../../constant/load_status.dart';
import '../../repositories/api/api.dart';

class TransferUsingBank extends StatelessWidget {
  final String bankCode;

  const TransferUsingBank({super.key, required this.bankCode});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransferUsingBankCubit(
        context.read<Api>(),
      ),
      child: _TransferUsingBankPage(
        bankCode: bankCode,
      ),
    );
  }
}

class _TransferUsingBankPage extends StatelessWidget {
  final String bankCode;

  _TransferUsingBankPage({super.key, required this.bankCode});

  final String _to = generateVietnameseName();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocConsumer<TransferUsingBankCubit, TransferUsingBankState>(
        builder: (context, state) {
          if (state.loadStatus == LoadStatus.Loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                _buildBalanceSection(),
                _buildTransferForm(context),
              ],
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
                    amount: state.amount,
                    note: state.notes,
                    phone: '',
                    date: '',
                    bankDate: state.date,
                    bankCode: state.code,
                    to: state.to,
                    from: 'thnu',
                  ),
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
        "Transfer through Bank",
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
      centerTitle: true,
      backgroundColor: btntxt,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Image.asset('assets/image/help.png', height: 26),
        ),
      ],
    );
  }

  Widget _buildBalanceSection() {
    return Container(
      width: double.infinity,
      color: btntxt,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your Balance",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                "\$ 24,321,900",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ],
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.wallet, color: btntxt),
            label: const Text(
              "Top Up",
              style: TextStyle(color: btntxt),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTransferForm(BuildContext context) {
    final cubit = context.read<TransferUsingBankCubit>();

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage(
                fetchBankImageWith(bankCode),
              ),
            ),
            title: Text(_to, style: const TextStyle(fontSize: 16)),
            subtitle: const Text("••••• •••• 80901"),
            trailing: const Icon(Icons.edit, color: btn),
          ),
          const SizedBox(height: 30),
          _buildAmountField(context, cubit),
          const SizedBox(height: 40),
          _buildNotesField(context, cubit),
          const SizedBox(height: 50),
          _buildSubmitButton(context),
        ],
      ),
    );
  }

  Widget _buildAmountField(BuildContext context, TransferUsingBankCubit cubit) {
    return Column(
      children: [
        const Text("Set Amount",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('\$', style: TextStyle(fontSize: 32)),
            const SizedBox(width: 10),
            SizedBox(
              width: 100,
              child: TextField(
                onChanged: cubit.updateAmount,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 32),
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNotesField(BuildContext context, TransferUsingBankCubit cubit) {
    return TextField(
      onChanged: cubit.updateNotes,
      decoration: InputDecoration(
        hintText: "Add a note (optional)",
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      maxLines: 3,
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: context.watch<TransferUsingBankCubit>().state.isButtonEnabled
          ? () {
              context.read<TransferUsingBankCubit>().transfer(
                    _to,
                    bankCode,
                  );
            }
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Center(
        child: const Text("Proceed to Transfer"),
      ),
    );
  }
}
