import 'package:bloc/bloc.dart';

part 'submited_slip_state.dart';

class SubmitedSlipCubit extends Cubit<SubmitedSlipState> {
  SubmitedSlipCubit() : super(SubmitedSlipState.init());
}
