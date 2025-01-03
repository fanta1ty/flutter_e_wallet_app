import 'package:bloc/bloc.dart';
import 'package:e_wallet/models/response/signup_response.dart';
import 'package:e_wallet/repositories/api/api.dart';

import '../../constant/load_status.dart';
import '../../models/request/signup_request.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final Api api;

  SignupCubit(this.api) : super(SignupState.init());

  void updateEmail(String email) {
    emit(state.copyWith(email: email));
    _validateForm();
  }

  void updatePassword(String password) {
    emit(state.copyWith(password: password));
    _validateForm();
  }

  void updateConfirmPassword(String confirmPassword) {
    emit(state.copyWith(confirmPassword: confirmPassword));
    _validateForm();
  }

  void _validateForm() {
    final isFormValid = state.email.contains('@') &&
        state.password.length >= 6 &&
        state.password == state.confirmPassword;

    emit(state.copyWith(isButtonEnabled: isFormValid));
  }

  Future<void> signup() async {
    emit(state.copyWith(loadStatus: LoadStatus.Loading));
    var result = await api.signup(SignUpRequest(
      email: state.email,
      password: state.password,
      confirmPassword: state.confirmPassword,
    ));

    if (result.success) {
      emit(state.copyWith(loadStatus: LoadStatus.Done, response: result));
    } else {
      emit(state.copyWith(loadStatus: LoadStatus.Error, response: result));
    }
  }
}
