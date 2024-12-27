import 'package:e_wallet/constant/colours.dart';
import 'package:e_wallet/screen/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

TextEditingController emailsig = TextEditingController();
TextEditingController passsig = TextEditingController();
TextEditingController cpass = TextEditingController();

class _SignupState extends State<Signup> {
  void createUser() async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailsig.text, password: passsig.text);

      final snackBar = SnackBar(
        backgroundColor: btn,
        content: const Text(
          'User sucessfully add....',
          style: TextStyle(color: Colors.white),
        ),
        action: SnackBarAction(label: '', onPressed: () {}),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      emailsig.clear();
      passsig.clear();
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        final snackBar = SnackBar(
          content: const Text(
            'The password provided is too week.',
            style: TextStyle(color: Colors.white),
          ),
          action: SnackBarAction(label: '', onPressed: () {}),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (e.code == 'email-already-in-use') {
        final snackBar = SnackBar(
          content: const Text(
            'The account already exists for that email.',
            style: TextStyle(color: Colors.black),
          ),
          action: SnackBarAction(label: '', onPressed: () {}),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      print(e);
      final snackBar = SnackBar(
        content: const Text(
          'Something went wrong',
          style: TextStyle(color: Colors.white),
        ),
        action: SnackBarAction(label: '', onPressed: () {}),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          child: Container(
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
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: Text(
                      'Demo E-Wallet',
                      style: TextStyle(
                          fontSize: 16, fontFamily: 'pppins', color: btntxt),
                      textAlign: TextAlign.center,
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 315,
                  child: TextField(
                    controller: emailsig,
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
                  height: 20,
                ),
                Container(
                  width: 315,
                  child: TextField(
                    controller: passsig,
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
                            borderSide:
                                const BorderSide(color: btn, width: 2.0))),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 315,
                  child: TextField(
                    controller: cpass,
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
                            borderSide:
                                const BorderSide(color: btn, width: 2.0))),
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
                      createUser();
                    },
                    child: Text(
                      "Sign up",
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
                      onPressed: () {},
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
      )),
    );
  }
}
