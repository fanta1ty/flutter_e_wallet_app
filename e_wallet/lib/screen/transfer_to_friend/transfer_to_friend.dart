import 'package:e_wallet/constant/colours.dart';
import 'package:e_wallet/models/request/transfer_request.dart';
import 'package:e_wallet/screen/transfer_to_friend/transfer_to_friend_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant/load_status.dart';
import '../../l10n/app_localizations.dart';
import '../../repositories/api/api.dart';
import '../submited_to_friend/submited_to_friend.dart';

class TransferToFriend extends StatelessWidget {
  const TransferToFriend({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransferToFriendCubit(context.read<Api>()),
      child: const _TransferToFriendPage(),
    );
  }
}

class _TransferToFriendPage extends StatelessWidget {
  const _TransferToFriendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocConsumer<TransferToFriendCubit, TransferToFriendState>(
        builder: (context, state) {
          if (state.loadStatus == LoadStatus.Loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                _buildBalanceCard(context),
                _buildTransferForm(context),
              ],
            ),
          );
        },
        listener: (context, state) {
          if (state.isTransferSuccess && state.loadStatus == LoadStatus.Done) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SubmitedToFriend(
                  request: TransferRequest(
                    amount: state.amount,
                    note: state.notes,
                    phone: state.phone,
                    date: state.date,
                    bankDate: '',
                    bankCode: '',
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
    final appLoc = AppLocalizations.of(context)!;
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        appLoc.transfer_to_friends,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      backgroundColor: btntxt,
      elevation: 0,
    );
  }

  Widget _buildBalanceCard(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      color: btntxt,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appLoc.your_balance,
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                "\$ 24,321,900",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ],
          ),
          // ElevatedButton.icon(
          //   onPressed: () {},
          //   icon: const Icon(Icons.wallet, color: btntxt),
          //   label: Text(
          //     appLoc.top_up,
          //     style: TextStyle(color: btntxt),
          //   ),
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Colors.white,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //     padding: const EdgeInsets.symmetric(horizontal: 20),
          //   ),
          // )
        ],
      ),
    );
  }

  Widget _buildTransferForm(BuildContext context) {
    final cubit = context.read<TransferToFriendCubit>();
    final appLoc = AppLocalizations.of(context)!;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
            label: appLoc.phone_number,
            hint: appLoc.input_phone_number,
            icon: Icons.contact_page,
            onTap: () {},
            onChanged: cubit.updatePhone,
          ),
          const SizedBox(height: 30),
          _buildAmountField(context, cubit),
          const SizedBox(height: 30),
          _buildTextField(
            label: appLoc.notes_optional,
            hint: appLoc.write_your_notes_here,
            onChanged: cubit.updateNotes,
            maxLines: 3,
          ),
          const SizedBox(height: 50),
          _buildSubmitButton(context),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    IconData? icon,
    void Function()? onTap,
    void Function(String)? onChanged,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 10),
        TextField(
          onChanged: onChanged,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey[100],
            suffixIcon: icon != null
                ? IconButton(onPressed: onTap, icon: Icon(icon, color: btntxt))
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAmountField(BuildContext context, TransferToFriendCubit cubit) {
    final appLoc = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          appLoc.set_amount,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('\$', style: TextStyle(fontSize: 32)),
            const SizedBox(width: 5),
            SizedBox(
              width: 100,
              child: TextField(
                style: const TextStyle(fontSize: 32),
                keyboardType: TextInputType.number,
                onChanged: cubit.updateAmount,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    return ElevatedButton(
      onPressed: context.watch<TransferToFriendCubit>().state.isButtonEnabled
          ? () => context.read<TransferToFriendCubit>().transfer()
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Center(child: Text(appLoc.proceed_to_transfer)),
    );
  }
}
