import 'package:e_wallet/constant/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant/load_status.dart';
import '../../models/request/transfer_request.dart';
import '../../repositories/api/api.dart';

part 'transfer_to_friend_state.dart';

class TransferToFriendCubit extends Cubit<TransferToFriendState> {
  final Api api;

  TransferToFriendCubit(this.api)
      : super(
          TransferToFriendState.init(),
        );

  Future<void> setButtonEnabled(bool isEnabled) async {
    emit(state.copyWith(isButtonEnabled: isEnabled));
  }

  void updatePhone(String phone) {
    emit(state.copyWith(phone: phone));
    _validateForm();
  }

  void updateNotes(String notes) {
    emit(state.copyWith(notes: notes));
  }

  void updateAmount(String amount) {
    emit(state.copyWith(amount: amount));
    _validateForm();
  }

  void _validateForm() {
    final isEnabled = state.phone.isNotEmpty &&
        state.amount.isNotEmpty &&
        double.tryParse(state.amount) != null;
    emit(state.copyWith(isButtonEnabled: isEnabled));
  }

  Future<void> transfer() async {
    emit(
      state.copyWith(
        loadStatus: LoadStatus.Loading,
        date: DateTime.now().toIso8601String(),
        to: generateVietnameseName(),
      ),
    );

    await api.transfer(
      TransferRequest(
        amount: '-${state.amount}',
        note: state.notes,
        phone: state.phone,
        date: state.date,
        bankDate: '',
        bankCode: '',
        to: state.to,
        from: 'thnu',
      ),
    );

    emit(state.copyWith(
      loadStatus: LoadStatus.Done,
      isTransferSuccess: true,
    ));
  }
}
