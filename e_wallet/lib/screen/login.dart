import 'package:e_wallet/constant/colours.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() => _LoginState();
}

TextEditingController email = TextEditingController();
TextEditingController pass = TextEditingController();

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          color: btntxt,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            ),
            margin: EdgeInsets.only(top: 100),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
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
                    style: TextStyle(fontSize: 18, fontFamily: 'pppins'),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 315,
                  child: TextField(
                    controller: email,
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
                            borderSide:
                                const BorderSide(color: btn, width: 2.0))),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 315,
                  child: TextField(
                    controller: pass,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: ' Password',
                        hintStyle: TextStyle(color: Colors.grey),
                        fillColor: Colors.grey[100],
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: btn, width: 2.0)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: btn, width: 2.0))),
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
                      // Navigator.push(
                      //     context, MaterialPageRoute(builder: (context) => Home()));
                      // firbaselogin();
                    },
                    child: Text(
                      'Sign in',
                      style: TextStyle(color: Colors.white, fontSize: 16),
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
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => Signup()));
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
      )),
    );
  }
}
