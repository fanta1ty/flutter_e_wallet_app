import 'package:bloc/bloc.dart';

part 'transfer_state.dart';

class TransferCubit extends Cubit<TransferState> {
  TransferCubit() : super(TransferState.init());
}
