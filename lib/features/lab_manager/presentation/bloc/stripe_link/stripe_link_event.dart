import 'package:equatable/equatable.dart';

abstract class StripeLinkEvent extends Equatable {
  const StripeLinkEvent();

  @override
  List<Object?> get props => [];
}

class StripeLinkRequested extends StripeLinkEvent {
  const StripeLinkRequested();
}