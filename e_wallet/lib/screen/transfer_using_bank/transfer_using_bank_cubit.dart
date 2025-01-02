import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constant/load_status.dart';

part 'transfer_using_bank_state.dart';

class TransferUsingBankCubit extends Cubit<TransferUsingBankState> {
  TransferUsingBankCubit()
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

  Future<void> checkIsProceedToTransfer(
    bool isProceedToTransfer,
  ) async {
    emit(
      state.copyWith(isProceedToTransfer: isProceedToTransfer),
    );
    if (isProceedToTransfer) {
      emit(
        state.copyWith(
          loadStatus: LoadStatus.Loading,
        ),
      );
    }
  }

  Future<void> saveAmount(
    String amount,
    String notes,
  ) async {
    final doc = FirebaseFirestore.instance
        .collection(
          'transactions',
        )
        .doc();

    await doc.set(
      {
        'amount': amount,
        'note': notes,
        'bankDate': DateTime.now().toIso8601String(),
        'phone': '',
        'date': '',
      },
    );

    emit(
      state.copyWith(
        loadStatus: LoadStatus.Done,
      ),
    );

    emit(
      state.copyWith(isTransferSuccess: true),
    );
  }
}
