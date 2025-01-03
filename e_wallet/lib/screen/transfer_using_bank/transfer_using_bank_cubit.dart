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
        amount: '-$amount',
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
