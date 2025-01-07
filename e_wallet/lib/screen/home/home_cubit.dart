import 'package:bloc/bloc.dart';

import '../../constant/load_status.dart';
import '../../models/response/transaction_response.dart';
import '../../repositories/api/api.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final Api api;

  HomeCubit(this.api) : super(HomeState.init());

  Future<void> fetchTransactions() async {
    emit(state.copyWith(loadStatus: LoadStatus.Loading));
    var result = await api.fetchTransactions('transactions');

    final topUpCount = result
        .where(
          (transaction) => transaction.type == 'top_up',
        )
        .length;
    final transferCount = result
        .where(
          (transaction) => transaction.type == 'transfer',
        )
        .length;
    final withdrawCount = result
        .where(
          (transaction) => transaction.type == 'withdraw',
        )
        .length;

    emit(
      state.copyWith(
        loadStatus: LoadStatus.Done,
        responses: result,
        topUpCount: topUpCount,
        transferCount: transferCount,
        withdrawCount: withdrawCount,
      ),
    );
  }
}
