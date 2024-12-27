import 'package:bloc/bloc.dart';

part 'nabbar_state.dart';

class NabbarCubit extends Cubit<NabbarState> {
  NabbarCubit() : super(NabbarState.init());

  Future<void> setPage(int page) async {
    emit(state.copyWith(index: page));
  }
}
