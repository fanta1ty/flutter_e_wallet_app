import 'package:bloc/bloc.dart';

import '../../constant/load_status.dart';

part 'transfer_to_bank_state.dart';

class TransferToBankCubit extends Cubit<TransferToBankState> {
  TransferToBankCubit()
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
}
