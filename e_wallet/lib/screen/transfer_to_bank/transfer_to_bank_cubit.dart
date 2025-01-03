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

  Future<void> transfer(
    String amount,
    String note,
    String phone,
    String date,
    String bankDate,
    String bankCode,
    String to,
    String from,
  ) async {
    emit(state.copyWith(loadStatus: LoadStatus.Loading));
    await api.transfer(
      TransferRequest(
        amount: amount,
        note: note,
        phone: phone,
        date: date,
        bankDate: bankDate,
        bankCode: bankCode,
        to: to,
        from: from,
      ),
    );
    emit(state.copyWith(loadStatus: LoadStatus.Done));
    emit(state.copyWith(isTransferSuccess: true));
  }
}
