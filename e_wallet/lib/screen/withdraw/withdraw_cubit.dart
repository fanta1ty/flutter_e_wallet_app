import 'package:bloc/bloc.dart';
import 'package:e_wallet/models/request/withdraw_request.dart';

import '../../constant/load_status.dart';
import '../../models/response/transaction_response.dart';
import '../../repositories/api/api.dart';

part 'withdraw_state.dart';

class WithdrawCubit extends Cubit<WithdrawState> {
  final Api api;

  WithdrawCubit(this.api) : super(WithdrawState.init());

  void updateAmount(String amount) {
    emit(state.copyWith(amount: amount));
    _validateForm();
  }

  void _validateForm() {
    final isEnabled =
        state.amount.isNotEmpty && double.tryParse(state.amount) != null;
    emit(state.copyWith(isButtonEnabled: isEnabled));
  }

  Future<void> fetchTransactions() async {
    emit(state.copyWith(loadStatus: LoadStatus.Loading));
    var result = await api.fetchTransactions('transactions');

    emit(state.copyWith(
      loadStatus: LoadStatus.Done,
      responses: result
          .where(
            (transaction) => transaction.type == 'withdraw',
          )
          .toList(),
    ));
  }

  Future<void> withdraw() async {
    emit(state.copyWith(
      loadStatus: LoadStatus.Loading,
      date: DateTime.now().toIso8601String(),
    ));

    await api.withdraw(
      WithdrawRequest(
        amount: '-${state.amount}',
        date: state.date,
      ),
    );

    await fetchTransactions();
    emit(state.copyWith(isWithdrawSuccess: true));
  }
}
