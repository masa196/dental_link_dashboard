import 'package:equatable/equatable.dart';


abstract class ShowNotificationsEvent extends Equatable {

  const ShowNotificationsEvent();


  @override
  List<Object?> get props => [];

}



class ShowNotificationsRequested
    extends ShowNotificationsEvent {

  const ShowNotificationsRequested();

}