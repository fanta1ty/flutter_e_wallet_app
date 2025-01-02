import 'package:bloc/bloc.dart';

part 'transfer_to_friend_state.dart';

class TransferToFriendCubit extends Cubit<TransferToFriendState> {
  TransferToFriendCubit()
      : super(
          TransferToFriendState.init(
            false,
          ),
        );

  Future<void> setButtonEnabled(bool isEnabled) async {
    emit(state.copyWith(isButtonEnabled: isEnabled));
  }
}
