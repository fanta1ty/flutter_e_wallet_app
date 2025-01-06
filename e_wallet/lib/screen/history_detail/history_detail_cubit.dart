import 'package:bloc/bloc.dart';

part 'history_detail_state.dart';

class HistoryDetailCubit extends Cubit<HistoryDetailState> {
  HistoryDetailCubit() : super(HistoryDetailState.init());
}
