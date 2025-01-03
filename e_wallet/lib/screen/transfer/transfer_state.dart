part of 'transfer_cubit.dart';

class TransferState {
  final LoadStatus loadStatus;
  List<TransactionResponse> responses;

  final String transactionImage;

  TransferState.init({
    this.loadStatus = LoadStatus.Init,
    this.responses = const [],
    this.transactionImage = '',
  });

//<editor-fold desc="Data Methods">
  TransferState({
    required this.loadStatus,
    required this.responses,
    required this.transactionImage,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransferState &&
          runtimeType == other.runtimeType &&
          loadStatus == other.loadStatus &&
          responses == other.responses &&
          transactionImage == other.transactionImage);

  @override
  int get hashCode =>
      loadStatus.hashCode ^ responses.hashCode ^ transactionImage.hashCode;

  @override
  String toString() {
    return 'TransferState{' +
        ' loadStatus: $loadStatus,' +
        ' responses: $responses,' +
        ' transactionImage: $transactionImage,' +
        '}';
  }

  TransferState copyWith({
    LoadStatus? loadStatus,
    List<TransactionResponse>? responses,
    String? transactionImage,
  }) {
    return TransferState(
      loadStatus: loadStatus ?? this.loadStatus,
      responses: responses ?? this.responses,
      transactionImage: transactionImage ?? this.transactionImage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'loadStatus': this.loadStatus,
      'responses': this.responses,
      'transactionImage': this.transactionImage,
    };
  }

  factory TransferState.fromMap(Map<String, dynamic> map) {
    return TransferState(
      loadStatus: map['loadStatus'] as LoadStatus,
      responses: map['responses'] as List<TransactionResponse>,
      transactionImage: map['transactionImage'] as String,
    );
  }

//</editor-fold>
}
