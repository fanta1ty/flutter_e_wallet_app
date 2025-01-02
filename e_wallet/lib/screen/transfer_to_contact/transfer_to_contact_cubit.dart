import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'transfer_to_contact_state.dart';

class TransferToContactCubit extends Cubit<TransferToContactState> {
  TransferToContactCubit()
      : super(
          TransferToContactState.init(
            false,
            false,
            false,
          ),
        );

  Future<void> setButtonEnabled(
    bool isEnabled,
  ) async {
    emit(state.copyWith(isButtonEnabled: isEnabled));
  }

  Future<void> checkIsProceedToTransfer(
    bool isProceedToTransfer,
  ) async {
    emit(state.copyWith(isProceedToTransfer: isProceedToTransfer));
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
        'date': DateTime.now().toIso8601String(),
      },
    );

    emit(state.copyWith(isTransferSuccess: true));
  }
}