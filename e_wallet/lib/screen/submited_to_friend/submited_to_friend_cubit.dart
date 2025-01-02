import 'package:bloc/bloc.dart';

part 'submited_to_friend_state.dart';

class SubmitedToFriendCubit extends Cubit<SubmitedToFriendState> {
  SubmitedToFriendCubit()
      : super(
          SubmitedToFriendState.init(),
        );
}
