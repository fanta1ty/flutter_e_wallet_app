part of 'home_cubit.dart';

class HomeState {
  final LoadStatus loadStatus;
  List<TransactionResponse> responses;
  final int topUpCount;
  final int transferCount;
  final int withdrawCount;

  HomeState.init({
    this.loadStatus = LoadStatus.Init,
    this.topUpCount = 0,
    this.transferCount = 0,
    this.withdrawCount = 0,
    this.responses = const [],
  });

//<editor-fold desc="Data Methods">
  HomeState({
    required this.loadStatus,
    required this.responses,
    required this.topUpCount,
    required this.transferCount,
    required this.withdrawCount,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HomeState &&
          runtimeType == other.runtimeType &&
          loadStatus == other.loadStatus &&
          responses == other.responses &&
          topUpCount == other.topUpCount &&
          transferCount == other.transferCount &&
          withdrawCount == other.withdrawCount);

  @override
  int get hashCode =>
      loadStatus.hashCode ^
      responses.hashCode ^
      topUpCount.hashCode ^
      transferCount.hashCode ^
      withdrawCount.hashCode;

  @override
  String toString() {
    return 'HomeState{' +
        ' loadStatus: $loadStatus,' +
        ' responses: $responses,' +
        ' topUpCount: $topUpCount,' +
        ' transferCount: $transferCount,' +
        ' withdrawCount: $withdrawCount,' +
        '}';
  }

  HomeState copyWith({
    LoadStatus? loadStatus,
    List<TransactionResponse>? responses,
    int? topUpCount,
    int? transferCount,
    int? withdrawCount,
  }) {
    return HomeState(
      loadStatus: loadStatus ?? this.loadStatus,
      responses: responses ?? this.responses,
      topUpCount: topUpCount ?? this.topUpCount,
      transferCount: transferCount ?? this.transferCount,
      withdrawCount: withdrawCount ?? this.withdrawCount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'loadStatus': this.loadStatus,
      'responses': this.responses,
      'topUpCount': this.topUpCount,
      'transferCount': this.transferCount,
      'withdrawCount': this.withdrawCount,
    };
  }

  factory HomeState.fromMap(Map<String, dynamic> map) {
    return HomeState(
      loadStatus: map['loadStatus'] as LoadStatus,
      responses: map['responses'] as List<TransactionResponse>,
      topUpCount: map['topUpCount'] as int,
      transferCount: map['transferCount'] as int,
      withdrawCount: map['withdrawCount'] as int,
    );
  }

//</editor-fold>
}
