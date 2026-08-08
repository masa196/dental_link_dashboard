import 'package:equatable/equatable.dart';

sealed class GetOrderStagesEvent extends Equatable {
  const GetOrderStagesEvent();

  @override
  List<Object?> get props => [];
}

final class GetOrderStagesRequested
    extends GetOrderStagesEvent {
  const GetOrderStagesRequested();
}

final class GetOrderStagesRefreshed
    extends GetOrderStagesEvent {
  const GetOrderStagesRefreshed();
}