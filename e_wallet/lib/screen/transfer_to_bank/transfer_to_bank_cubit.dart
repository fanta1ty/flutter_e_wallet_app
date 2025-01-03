import 'package:bloc/bloc.dart';
import 'package:e_wallet/models/request/transfer_request.dart';

import '../../constant/load_status.dart';
import '../../repositories/api/api.dart';

part 'transfer_to_bank_state.dart';

class TransferToBankCubit extends Cubit<TransferToBankState> {
  final Api api;

  TransferToBankCubit(this.api)
      : super(
          TransferToBankState.init(),
        );

  Future<void> setButtonEnabled(
    bool isEnabled,
  ) async {
    emit(
      state.copyWith(isButtonEnabled: isEnabled),
    );
  }

  void updateAmount(String amount) {
    emit(state.copyWith(amount: amount));
    _validateForm();
  }

  void updateTo(String to) {
    emit(state.copyWith(to: to));
    _validateForm();
  }

  void updateNotes(String notes) {
    emit(state.copyWith(notes: notes));
  }

  void updateBankCode(String code) {
    emit(state.copyWith(code: code));
    _validateForm();
  }

  void _validateForm() {
    final isEnabled = state.code.isNotEmpty &&
        state.to.isNotEmpty &&
        state.amount.isNotEmpty &&
        double.tryParse(state.amount) != null;
    emit(state.copyWith(isButtonEnabled: isEnabled));
  }

  Future<void> transfer() async {
    emit(state.copyWith(
      loadStatus: LoadStatus.Loading,
      date: DateTime.now().toIso8601String(),
    ));
    await api.transfer(
      TransferRequest(
        amount: '-${state.amount}',
        note: state.notes,
        phone: '',
        date: '',
        bankDate: state.date,
        bankCode: state.code,
        to: state.to,
        from: 'thnu',
      ),
    );
    emit(state.copyWith(loadStatus: LoadStatus.Done));
    emit(state.copyWith(isTransferSuccess: true));
  }
}
