import 'package:bloc/bloc.dart';
import 'package:e_wallet/models/response/transaction_response.dart';

import '../../constant/load_status.dart';
import '../../repositories/api/api.dart';

part 'transfer_state.dart';

class TransferCubit extends Cubit<TransferState> {
  final Api api;

  TransferCubit(this.api) : super(TransferState.init());

  Future<void> fetchTransactions() async {
    emit(state.copyWith(loadStatus: LoadStatus.Loading));
    var result = await api.fetchTransactions('transactions');
    emit(state.copyWith(
      loadStatus: LoadStatus.Done,
      responses: result,
    ));
  }
}
