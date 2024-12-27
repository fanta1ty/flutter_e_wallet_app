import 'package:e_wallet/models/request/login_request.dart';
import 'package:e_wallet/models/response/login_response.dart';
import 'package:e_wallet/repositories/api/api.dart';
import 'package:e_wallet/repositories/log/log.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ApiImpl implements Api {
  Log log;

  ApiImpl(this.log);

  @override
  Future<LoginResponse> login(LoginRequest request) async {
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
            success: false, errorMessage: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
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
}
