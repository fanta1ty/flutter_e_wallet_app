import 'package:bloc/bloc.dart';

import '../../constant/load_status.dart';

part 'transfer_to_banks_state.dart';

class TransferToBanksCubit extends Cubit<TransferToBanksState> {
  TransferToBanksCubit() : super(TransferToBanksState.init());
}
