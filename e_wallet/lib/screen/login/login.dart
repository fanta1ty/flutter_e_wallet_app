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
      child: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  String _email = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<LoginCubit, LoginState>(builder: (context, state) {
          return state.loadStatus == LoadStatus.Loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SafeArea(
                  child: SingleChildScrollView(
                  child: Container(
                    color: btntxt,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30)),
                      ),
                      margin: EdgeInsets.only(top: 100),
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
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: Text(
                              'Welcome back',
                              style:
                                  TextStyle(fontSize: 18, fontFamily: 'pppins'),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 30,
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
                            height: 30,
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
                                      borderSide: const BorderSide(
                                          color: btn, width: 2.0)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: btn, width: 2.0))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 158, top: 10),
                            child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Forgot your password?',
                                  style: TextStyle(
                                      fontFamily: 'pppinsbold',
                                      fontSize: 12,
                                      color: btntxt),
                                )),
                          ),
                          SizedBox(
                            height: 10,
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
                                context.read<LoginCubit>().login(LoginRequest(
                                    email: _email, password: _password));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: btn,
                                minimumSize: Size(300, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Sign in',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
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
                                          builder: (context) => Signup()));
                                },
                                child: Text(
                                  "Create new account",
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Nabbar()));
          }
        }));
  }
}
