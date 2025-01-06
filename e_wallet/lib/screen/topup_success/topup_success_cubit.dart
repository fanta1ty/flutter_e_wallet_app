import 'package:bloc/bloc.dart';

part 'topup_success_state.dart';

class TopupSuccessCubit extends Cubit<TopupSuccessState> {
  TopupSuccessCubit() : super(TopupSuccessState.init());
}
