import 'package:e_wallet/screen/transfer_to_bank/transfer_to_bank.dart';
import 'package:e_wallet/screen/transfer_to_banks/transfer_to_banks_cubit.dart';
import 'package:e_wallet/screen/transfer_using_bank/transfer_using_bank.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant/banks.dart';
import '../../constant/colours.dart';
import '../../constant/load_status.dart';

class TransferToBanks extends StatelessWidget {
  const TransferToBanks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransferToBanksCubit(),
      child: const _TransferToBanksPage(),
    );
  }
}

class _TransferToBanksPage extends StatefulWidget {
  const _TransferToBanksPage({super.key});

  @override
  State<_TransferToBanksPage> createState() => _TransferToBanksPageState();
}

class _TransferToBanksPageState extends State<_TransferToBanksPage> {
  String _search = "";
  final List<Map<String, String>> contacts = [
    {"code": "TCB"},
    {"code": "VCB"},
    {"code": "CTG"},
    {"code": "MBB"},
    {"code": "ACB"},
    {"code": "HDB"},
    {"code": "TPB"},
    {"code": "OCB"},
    {"code": "SCB"},
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TransferToBanksCubit, TransferToBanksState>(
      builder: (context, state) {
        return state.loadStatus == LoadStatus.Loading
            ? const Center(child: CircularProgressIndicator())
            : Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new,
                        color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TransferToBank(),
                        ),
                      );
                    },
                  ),
                  title: const Text(
                    "Transfer to Banks",
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
                ),
                body: Container(
                  color: btntxt,
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      _buildSearchBar(),
                      const SizedBox(height: 30),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                child: Text(
                                  "All Banks",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(child: _buildBankList(context)),
                            ],
                          ),
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

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        onChanged: (value) {
          setState(() {
            _search = value;
          });
        },
        decoration: InputDecoration(
          hintText: "Search Bank Code",
          filled: true,
          fillColor: Colors.white,
          suffixIcon: const Icon(Icons.search, color: btntxt),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildBankList(BuildContext context) {
    final filteredContacts = contacts
        .where((contact) =>
            contact['code']!.toLowerCase().contains(_search.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredContacts.length,
      itemBuilder: (context, index) {
        final contact = filteredContacts[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            leading: CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage(
                fetchBankImageWith(contact['code']!),
              ),
            ),
            title: Text(
              fetchBankNameWith(contact['code']!),
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              final code = contact['code']!;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TransferUsingBank(bankCode: code),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
