import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecases/show_notifications_usecase.dart';
import 'show_notifications_event.dart';
import 'show_notifications_state.dart';


@injectable
class ShowNotificationsBloc
    extends Bloc<ShowNotificationsEvent, ShowNotificationsState> {

  ShowNotificationsBloc(
    this.showNotificationsUseCase,
  ) : super(const ShowNotificationsState()) {

    on<ShowNotificationsRequested>(_showNotifications);

  }


  final ShowNotificationsUseCase showNotificationsUseCase;


  Future<void> _showNotifications(
    ShowNotificationsRequested event,
    Emitter<ShowNotificationsState> emit,
  ) async {

    emit(
      state.copyWith(
        isLoading: true,
        failureMessage: null,
      ),
    );


    final result = await showNotificationsUseCase();


    result.fold(

      (failure) {

        emit(
          state.copyWith(
            isLoading: false,
            failureMessage: failure.message,
          ),
        );

      },


      (entity) {

        emit(
          state.copyWith(
            notifications: entity.notifications,
            isLoading: false,
            failureMessage: null,
          ),
        );

      },

    );

  }

}