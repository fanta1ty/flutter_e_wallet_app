import 'package:e_wallet/models/request/login_request.dart';
import 'package:e_wallet/models/request/signup_request.dart';
import 'package:e_wallet/models/request/topup_request.dart';
import 'package:e_wallet/models/request/transfer_request.dart';
import 'package:e_wallet/models/request/withdraw_request.dart';
import 'package:e_wallet/models/response/login_response.dart';
import 'package:e_wallet/models/response/signup_response.dart';
import 'package:e_wallet/models/response/transaction_response.dart';

abstract class Api {
  Future<LoginResponse> login(
    LoginRequest request,
  );

  Future<SignUpResponse> signup(
    SignUpRequest request,
  );

  Future<void> transfer(
    TransferRequest request,
  );

  Future<List<TransactionResponse>> fetchTransactions(
    String collectionPath,
  );

  Future<void> topUp(
    TopupRequest request,
  );

  Future<void> withdraw(
    WithdrawRequest request,
  );
}
