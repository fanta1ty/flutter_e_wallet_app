import 'package:e_wallet/constant/colours.dart';
import 'package:e_wallet/constant/load_status.dart';
import 'package:e_wallet/models/request/login_request.dart';
import 'package:e_wallet/repositories/api/api.dart';
import 'package:e_wallet/screen/login/login_cubit.dart';
import 'package:e_wallet/screen/nabbar/nabbar.dart';
import 'package:e_wallet/screen/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(context.read<Api>()),
      child: const _LoginPage(),
    );
  }
}

class _LoginPage extends StatelessWidget {
  const _LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    String _email = "";
    String _password = "";

    return Scaffold(
      backgroundColor: btntxt,
      body: BlocConsumer<LoginCubit, LoginState>(
        builder: (context, state) {
          if (state.loadStatus == LoadStatus.Loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 60, horizontal: 30),
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
                      )
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
                        'Welcome back',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 40),
                      _buildTextField(
                        hint: "Email",
                        icon: Icons.email,
                        onChanged: (value) => _email = value,
                      ),
                      const SizedBox(height: 30),
                      _buildTextField(
                        hint: "Password",
                        icon: Icons.lock,
                        obscureText: true,
                        onChanged: (value) => _password = value,
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot your password?',
                            style: TextStyle(
                                color: btntxt,
                                fontWeight: FontWeight.w500,
                                fontSize: 13),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          context.read<LoginCubit>().login(
                                LoginRequest(
                                    email: _email, password: _password),
                              );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: btn,
                          minimumSize: const Size(300, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadowColor: Colors.blueAccent.withOpacity(0.4),
                          elevation: 5,
                        ),
                        child: const Text(
                          'Sign in',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Signup()),
                          );
                        },
                        child: const Text(
                          "Create new account",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF4a4a4a),
                            fontWeight: FontWeight.w500,
                          ),
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Nabbar()),
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
}
