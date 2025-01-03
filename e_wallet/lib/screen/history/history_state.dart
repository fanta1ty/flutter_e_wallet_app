part of 'history_cubit.dart';

class HistoryState {
  final LoadStatus loadStatus;
  List<TransactionResponse> responses;

  final String transactionImage;

  HistoryState.init({
    this.loadStatus = LoadStatus.Init,
    this.responses = const [],
    this.transactionImage = '',
  });

//<editor-fold desc="Data Methods">
  HistoryState({
    required this.loadStatus,
    required this.responses,
    required this.transactionImage,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HistoryState &&
          runtimeType == other.runtimeType &&
          loadStatus == other.loadStatus &&
          responses == other.responses &&
          transactionImage == other.transactionImage);

  @override
  int get hashCode =>
      loadStatus.hashCode ^ responses.hashCode ^ transactionImage.hashCode;

  @override
  String toString() {
    return 'HistoryState{' +
        ' loadStatus: $loadStatus,' +
        ' responses: $responses,' +
        ' transactionImage: $transactionImage,' +
        '}';
  }

  HistoryState copyWith({
    LoadStatus? loadStatus,
    List<TransactionResponse>? responses,
    String? transactionImage,
  }) {
    return HistoryState(
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

  factory HistoryState.fromMap(Map<String, dynamic> map) {
    return HistoryState(
      loadStatus: map['loadStatus'] as LoadStatus,
      responses: map['responses'] as List<TransactionResponse>,
      transactionImage: map['transactionImage'] as String,
    );
  }

//</editor-fold>
}
