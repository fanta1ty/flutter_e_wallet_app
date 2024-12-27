import 'package:e_wallet/models/request/login_request.dart';
import 'package:e_wallet/models/response/login_response.dart';

abstract class Api {
  Future<LoginResponse> login(LoginRequest request);
}
