import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wallet/models/request/login_request.dart';
import 'package:e_wallet/models/request/transfer_request.dart';
import 'package:e_wallet/models/response/login_response.dart';
import 'package:e_wallet/models/response/transaction_response.dart';
import 'package:e_wallet/repositories/api/api.dart';
import 'package:e_wallet/repositories/log/log.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/request/signup_request.dart';
import '../../models/request/topup_request.dart';
import '../../models/request/withdraw_request.dart';
import '../../models/response/signup_response.dart';
import '../../models/user_session.dart';

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
      _storeUserInfo(
        credential.user?.uid,
        credential.user?.email,
        credential.user?.displayName,
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

  void _storeUserInfo(
    String? userId,
    String? email,
    String? displayName,
  ) {
    final session = UserSession();
    session.userId = userId;
    session.email = email;
    session.name = displayName;
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
    final userSession = UserSession();
    final doc = FirebaseFirestore.instance
        .collection(
          'transactions_${userSession.userId}',
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
        'from': userSession.email,
        'type': 'transfer',
      },
    );
  }

  @override
  Future<List<TransactionResponse>> fetchTransactions(
      String collectionPath) async {
    final sessionId = UserSession().userId;
    final path = '$collectionPath' + '_' + '$sessionId';
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final querySnapshot = await firestore.collection(path).get();
    final transactions = querySnapshot.docs
        .map(
          (doc) => TransactionResponse.fromMap(
            doc.data(),
            doc.id,
          ),
        )
        .toList();
    return Future(
      () => transactions,
    );
  }

  @override
  Future<void> topUp(TopupRequest request) async {
    final userSession = UserSession();
    final doc = FirebaseFirestore.instance
        .collection(
          'transactions_${userSession.userId}',
        )
        .doc();

    await doc.set(
      {
        'amount': request.amount,
        'note': '',
        'date': request.date,
        'phone': '',
        'bankDate': '',
        'bankCode': '',
        'to': userSession.email,
        'from': userSession.email,
        'type': 'top_up',
      },
    );
  }

  Future<void> withdraw(
    WithdrawRequest request,
  ) async {
    final userSession = UserSession();
    final doc = FirebaseFirestore.instance
        .collection(
          'transactions_${userSession.userId}',
        )
        .doc();

    await doc.set(
      {
        'amount': request.amount,
        'note': '',
        'date': request.date,
        'phone': '',
        'bankDate': '',
        'bankCode': '',
        'to': userSession.email,
        'from': userSession.email,
        'type': 'withdraw',
      },
    );
  }
}
