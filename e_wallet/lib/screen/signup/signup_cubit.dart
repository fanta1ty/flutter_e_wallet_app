import 'package:bloc/bloc.dart';
import 'package:e_wallet/models/response/signup_response.dart';
import 'package:e_wallet/repositories/api/api.dart';

import '../../constant/load_status.dart';
import '../../models/request/signup_request.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final Api api;

  SignupCubit(this.api) : super(SignupState.init());

  Future<void> signup(SignUpRequest request) async {
    emit(state.copyWith(loadStatus: LoadStatus.Loading));
    var result = await api.signup(request);
    if (result.success) {
      emit(state.copyWith(loadStatus: LoadStatus.Done, response: result));
    } else {
      emit(state.copyWith(loadStatus: LoadStatus.Error, response: result));
    }
  }
}
