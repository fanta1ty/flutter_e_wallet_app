import 'package:bloc/bloc.dart';
import 'package:e_wallet/constant/load_status.dart';
import 'package:e_wallet/models/request/login_request.dart';
import 'package:e_wallet/models/response/login_response.dart';
import 'package:e_wallet/repositories/api/api.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final Api api;

  LoginCubit(this.api) : super(LoginState.init());

  Future<void> login(LoginRequest request) async {
    emit(state.copyWith(loadStatus: LoadStatus.Loading));
    var result = await api.login(request);
    if (result.success) {
      emit(state.copyWith(loadStatus: LoadStatus.Done, response: result));
    } else {
      emit(state.copyWith(loadStatus: LoadStatus.Error, response: result));
    }
  }
}
