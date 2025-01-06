import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant/load_status.dart';
import '../../models/request/transfer_request.dart';
import '../../repositories/api/api.dart';

part 'transfer_using_bank_state.dart';

class TransferUsingBankCubit extends Cubit<TransferUsingBankState> {
  final Api api;

  TransferUsingBankCubit(this.api)
      : super(
          TransferUsingBankState.init(),
        );

  void updateAmount(String amount) {
    emit(state.copyWith(amount: amount));
    _validateForm();
  }

  void updateNotes(String notes) {
    emit(state.copyWith(notes: notes));
  }

  void _validateForm() {
    final isEnabled =
        state.amount.isNotEmpty && double.tryParse(state.amount) != null;
    emit(state.copyWith(isButtonEnabled: isEnabled));
  }

  Future<void> transfer(
    String to,
    String code,
  ) async {
    emit(state.copyWith(
      loadStatus: LoadStatus.Loading,
      to: to,
      date: DateTime.now().toIso8601String(),
    ));
    await api.transfer(
      TransferRequest(
        amount: '-${state.amount}',
        note: state.notes,
        phone: '',
        date: '',
        bankDate: state.date,
        bankCode: code,
        to: state.to,
        from: 'thnu',
      ),
    );
    emit(state.copyWith(loadStatus: LoadStatus.Done));
    emit(state.copyWith(isTransferSuccess: true));
  }
}
