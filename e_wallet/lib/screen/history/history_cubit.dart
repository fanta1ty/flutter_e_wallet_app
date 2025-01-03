import 'package:bloc/bloc.dart';

import '../../constant/load_status.dart';
import '../../models/response/transaction_response.dart';
import '../../repositories/api/api.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final Api api;

  HistoryCubit(this.api) : super(HistoryState.init());

  Future<void> fetchTransactions() async {
    emit(state.copyWith(loadStatus: LoadStatus.Loading));
    var result = await api.fetchTransactions('transactions');
    emit(state.copyWith(
      loadStatus: LoadStatus.Done,
      responses: result,
    ));
  }
}
