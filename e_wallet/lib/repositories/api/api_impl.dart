import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wallet/models/request/login_request.dart';
import 'package:e_wallet/models/request/transfer_request.dart';
import 'package:e_wallet/models/response/login_response.dart';
import 'package:e_wallet/repositories/api/api.dart';
import 'package:e_wallet/repositories/log/log.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/request/signup_request.dart';
import '../../models/response/signup_response.dart';

class ApiImpl implements Api {
  Log log;

  ApiImpl(this.log);

  @override
  Future<LoginResponse> login(
    LoginRequest request,
  ) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );
      return Future(() => LoginResponse(
          success: true,
          errorMessage: '',
          email: credential.user?.email,
          displayName: credential.user?.displayName));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Future(() => LoginResponse(
            success: false,
            errorMessage:
                'There is no existing user record corresponding to the provided identifier.'));
      } else if (e.code == 'invalid-password') {
        return Future(() => LoginResponse(
            success: false,
            errorMessage: 'Wrong password provided for that user.'));
      } else {
        return Future(
            () => LoginResponse(success: false, errorMessage: 'Generic Error'));
      }
    } catch (e) {
      return Future(
          () => LoginResponse(success: false, errorMessage: 'Generic Error'));
    }
  }

  @override
  Future<SignUpResponse> signup(
    SignUpRequest request,
  ) async {
    try {
      if (request.password != request.confirmPassword) {
        return Future(() =>
            SignUpResponse(success: false, errorMessage: 'Password not match'));
      }

      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: request.email, password: request.password);
      return Future(() => SignUpResponse(success: true, errorMessage: ''));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Future(() => SignUpResponse(
            success: false,
            errorMessage: 'The password provided is too week.'));
      } else if (e.code == 'email-already-exists') {
        return Future(() => SignUpResponse(
            success: false,
            errorMessage:
                'The provided email is already in use by an existing user.'));
      } else {
        return Future(() =>
            SignUpResponse(success: false, errorMessage: 'Generic Error'));
      }
    } catch (e) {
      return Future(
          () => SignUpResponse(success: false, errorMessage: 'Generic Error'));
    }
  }

  @override
  Future<void> transfer(
    TransferRequest request,
  ) async {
    final doc = FirebaseFirestore.instance
        .collection(
          'transactions',
        )
        .doc();

    await doc.set(
      {
        'amount': request.amount,
        'note': request.note,
        'date': request.date,
        'phone': request.phone,
        'bankDate': request.bankDate,
        'bankCode': request.bankCode,
        'to': request.to,
        'from': request.from,
      },
    );
  }
}
