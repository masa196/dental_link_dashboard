import 'package:equatable/equatable.dart';

abstract class LabStatisticsEvent extends Equatable {
  const LabStatisticsEvent();

  @override
  List<Object?> get props => [];
}

class LabStatisticsFetchRequested extends LabStatisticsEvent {
  const LabStatisticsFetchRequested();
}