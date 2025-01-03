import 'package:bloc/bloc.dart';

import '../../constant/load_status.dart';
import '../../repositories/api/api.dart';

part 'transfer_to_contact_state.dart';

class TransferToContactCubit extends Cubit<TransferToContactState> {
  final Api api;

  TransferToContactCubit(this.api)
      : super(
          TransferToContactState.init(),
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
  ) async {
    emit(state.copyWith(loadStatus: LoadStatus.Loading));
    await api.transfer(
      amount,
      note,
      phone,
      date,
      bankDate,
    );
    emit(state.copyWith(loadStatus: LoadStatus.Done));
    emit(state.copyWith(isTransferSuccess: true));
  }
}
