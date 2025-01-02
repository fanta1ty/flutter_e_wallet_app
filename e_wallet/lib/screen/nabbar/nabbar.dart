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
  _NabbarPage({super.key});

  int currentvalue = 0;

  getCurrentView() {
    if (currentvalue == 0) {
      return Home();
    } else if (currentvalue == 1) {
      // return chatVeiw();
    } else if (currentvalue == 2) {
      // return Signup();
    } else {
      return Container(
        child: Center(
            child: Text(
          "No Fav",
          style: TextStyle(fontSize: 20),
        )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<NabbarCubit, NabbarState>(
          builder: (context, state) {
            final index = context.watch<NabbarCubit>().state.index;
            if (index == 0) {
              return Home();
            } else {
              return Container(
                child: Center(
                  child: Text(
                    'In Developing',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              );
            }
          },
          listener: (context, state) {}),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: context.watch<NabbarCubit>().state.index,
          onTap: (index) {
            context.read<NabbarCubit>().setPage(index);
          },
          selectedItemColor: btntxt,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.compare_arrows), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: "History"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ]),
    );
  }
}
