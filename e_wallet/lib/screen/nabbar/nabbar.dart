import 'package:e_wallet/screen/history/history.dart';
import 'package:e_wallet/screen/home/home.dart';
import 'package:e_wallet/screen/nabbar/nabbar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant/colours.dart';

class Nabbar extends StatelessWidget {
  const Nabbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NabbarCubit(),
      child: _NabbarPage(),
    );
  }
}

class _NabbarPage extends StatelessWidget {
  const _NabbarPage({super.key});

  static final List<Widget> _pages = [
    const Home(),
    const History(),
    const Center(
      child: Text("In Developing"),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NabbarCubit, NabbarState>(builder: (context, state) {
      return Scaffold(
        body: _pages[state.index],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: context.watch<NabbarCubit>().state.index,
            onTap: (index) {
              context.read<NabbarCubit>().setPage(index);
            },
            selectedItemColor: btntxt,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.compare_arrows), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.history), label: "History"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile"),
            ]),
      );
    });
  }
}
