import 'package:e_wallet/constant/load_status.dart';
import 'package:e_wallet/models/request/signup_request.dart';
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
    String _email = "";
    String _password = "";
    String _confirmPassword = "";

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<SignupCubit, SignupState>(
        builder: (context, state) {
          return state.loadStatus == LoadStatus.Loading
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: SingleChildScrollView(
                    child: Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 50, horizontal: 30),
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 3,
                              blurRadius: 10,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/image/logo.png',
                              width: 250,
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Demo E-Wallet',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: btntxt,
                              ),
                            ),
                            const SizedBox(height: 40),
                            _buildTextField(
                              hint: "Email",
                              icon: Icons.email,
                              onChanged: (value) => _email = value,
                            ),
                            const SizedBox(height: 20),
                            _buildTextField(
                              hint: "Password",
                              icon: Icons.lock,
                              obscureText: true,
                              onChanged: (value) => _password = value,
                            ),
                            const SizedBox(height: 20),
                            _buildTextField(
                              hint: "Confirm Password",
                              icon: Icons.lock_outline,
                              obscureText: true,
                              onChanged: (value) => _confirmPassword = value,
                            ),
                            const SizedBox(height: 30),
                            _buildSignupButton(
                                context, _email, _password, _confirmPassword),
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
                                "Already have an account?",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
        },
        listener: (context, state) {
          if (state.loadStatus == LoadStatus.Error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.response!.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state.loadStatus == LoadStatus.Done) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'User successfully registered!',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.blueAccent,
              ),
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Login()),
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
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: btn, width: 2),
        ),
      ),
    );
  }

  Widget _buildSignupButton(BuildContext context, String email, String password,
      String confirmPassword) {
    return ElevatedButton(
      onPressed: () {
        context.read<SignupCubit>().signup(
              SignUpRequest(
                  email: email,
                  password: password,
                  confirmPassword: confirmPassword),
            );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: btn,
        minimumSize: const Size(300, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text(
        "Sign up",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
