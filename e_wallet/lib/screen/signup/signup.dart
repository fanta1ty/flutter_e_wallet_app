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
        child: _SignupPage());
  }
}

class _SignupPage extends StatelessWidget {
  _SignupPage({super.key});

  String _email = "";
  String _password = "";

  String _confirmPassword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<SignupCubit, SignupState>(builder: (context, state) {
          return state.loadStatus == LoadStatus.Loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SafeArea(
                  child: SingleChildScrollView(
                  child: Container(
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 30, right: 30, top: 20),
                            child: Center(
                              child: Image.asset(
                                'assets/image/logo.png',
                                width: 300,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 40, right: 40),
                              child: Text(
                                'Demo E-Wallet',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'pppins',
                                    color: btntxt),
                                textAlign: TextAlign.center,
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 315,
                            child: TextField(
                              onChanged: (value) => _email = value,
                              decoration: InputDecoration(
                                  hintText: ' Email',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  fillColor: Colors.grey[100],
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: btn, width: 2.0))),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 315,
                            child: TextField(
                              onChanged: (value) => _password = value,
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: ' Password',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  fillColor: Colors.grey[100],
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: btn, width: 2.0))),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 315,
                            child: TextField(
                              onChanged: (value) => _confirmPassword = value,
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: ' Confirm Password',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  fillColor: Colors.grey[100],
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: btn, width: 2.0))),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.blue, // Button color
                              borderRadius: BorderRadius.circular(12.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFd6deff),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3), // Shadow position
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<SignupCubit>().signup(
                                    SignUpRequest(
                                        email: _email,
                                        password: _password,
                                        confirmPassword: _confirmPassword));
                              },
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: btn,
                                minimumSize: Size(300, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()));
                                },
                                child: Text(
                                  "Already have an account",
                                  style: TextStyle(
                                      fontFamily: 'pppinsbold',
                                      fontSize: 13,
                                      color: Color(0xFF4a4a4a)),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
        }, listener: (context, state) {
          if (state.loadStatus == LoadStatus.Error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.response!.errorMessage),
                  backgroundColor: Colors.red),
            );
          } else if (state.loadStatus == LoadStatus.Done) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('User sucessfully add....',
                      style: TextStyle(color: Colors.white)),
                  backgroundColor: Colors.blueAccent),
            );

            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Login()));
          }
        }));
  }
}

TextEditingController emailsig = TextEditingController();
TextEditingController passsig = TextEditingController();
TextEditingController cpass = TextEditingController();
