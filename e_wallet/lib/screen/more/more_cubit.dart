import 'package:bloc/bloc.dart';

part 'more_state.dart';

class MoreCubit extends Cubit<MoreState> {
  MoreCubit() : super(MoreState.init());

  void changeLanguage(String language) {
    emit(state.copyWith(selectedLanguage: language));
  }
}
