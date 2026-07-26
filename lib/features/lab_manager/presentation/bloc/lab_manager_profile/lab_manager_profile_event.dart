import 'package:equatable/equatable.dart';

abstract class LabManagerProfileEvent extends Equatable {
  const LabManagerProfileEvent();

  @override
  List<Object?> get props => [];
}

class LabManagerProfileFetchRequested extends LabManagerProfileEvent {
  const LabManagerProfileFetchRequested();
}