import 'package:bloc/bloc.dart';

part 'withdraw_success_state.dart';

class WithdrawSuccessCubit extends Cubit<WithdrawSuccessState> {
  WithdrawSuccessCubit() : super(WithdrawSuccessState.init());
}
