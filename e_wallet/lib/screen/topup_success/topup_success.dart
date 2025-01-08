import 'package:e_wallet/screen/topup_success/topup_success_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../nabbar/nabbar.dart';

class TopUpSuccessScreen extends StatelessWidget {
  final String amount;

  const TopUpSuccessScreen({
    super.key,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TopupSuccessCubit(),
      child: _TopUpSuccessPage(
        amount: amount,
      ),
    );
  }
}

class _TopUpSuccessPage extends StatelessWidget {
  final String amount;

  _TopUpSuccessPage({
    super.key,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TopupSuccessCubit, TopupSuccessState>(
        builder: (context, state) {
          return Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 70,
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Top-Up Successful!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    '\$$amount has been added to your balance.',
                    style: const TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                  const SizedBox(height: 60),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Nabbar(),
                        ),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'Return to Home',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
