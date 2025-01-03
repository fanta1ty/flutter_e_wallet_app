import 'package:e_wallet/constant/load_status.dart';
import 'package:e_wallet/screen/signup/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant/colours.dart';
import '../../repositories/api/api.dart';
import '../login/login.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(context.read<Api>()),
      child: const _SignupPage(),
    );
  }
}

class _SignupPage extends StatelessWidget {
  const _SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SignupCubit, SignupState>(
        builder: (context, state) {
          return SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF00B4DB), Color(0xFF0083B0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 50),
                    child: Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 3,
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/image/logo.png', width: 200),
                          const SizedBox(height: 30),
                          const Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 40),
                          _buildTextField(
                            hint: "Email",
                            icon: Icons.email,
                            onChanged: context.read<SignupCubit>().updateEmail,
                          ),
                          const SizedBox(height: 20),
                          _buildTextField(
                            hint: "Password",
                            icon: Icons.lock,
                            obscureText: true,
                            onChanged:
                                context.read<SignupCubit>().updatePassword,
                          ),
                          const SizedBox(height: 20),
                          _buildTextField(
                            hint: "Confirm Password",
                            icon: Icons.lock_outline,
                            obscureText: true,
                            onChanged: context
                                .read<SignupCubit>()
                                .updateConfirmPassword,
                          ),
                          const SizedBox(height: 40),
                          ElevatedButton(
                            onPressed: state.isButtonEnabled
                                ? context.read<SignupCubit>().signup
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: btn,
                              minimumSize: const Size(300, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: state.loadStatus == LoadStatus.Loading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "Sign up",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                          ),
                          const SizedBox(height: 15),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()),
                              );
                            },
                            child: const Text(
                              "Already have an account? Sign in",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state.loadStatus == LoadStatus.Done) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Login()),
            );
          } else if (state.loadStatus == LoadStatus.Error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.response?.errorMessage ?? "Error occurred"),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required void Function(String) onChanged,
    bool obscureText = false,
    IconData? icon,
  }) {
    return TextField(
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: icon != null ? Icon(icon, color: btn) : null,
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: btn, width: 2),
        ),
      ),
    );
  }
}
