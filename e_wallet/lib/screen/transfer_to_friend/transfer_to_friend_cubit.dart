import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant/load_status.dart';
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
