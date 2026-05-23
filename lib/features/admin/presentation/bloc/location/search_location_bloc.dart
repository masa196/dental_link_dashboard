import 'dart:async';

import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/features/admin/data/models/location/location_model.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/create_lab_manager/create_lab_manager_entity.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

part 'search_location_event.dart';
part 'search_location_state.dart';

@Injectable()
class SearchLocationBloc
    extends Bloc<ISearchLocationEvent, SearchLocationState> {
  SearchLocationBloc() : super(SearchLocationInitial()) {
    on<SearchLocationEvent>(
      _searchLocation,
      transformer: _debounce(const Duration(milliseconds: 500)),
    );
  }

  Future<void> _searchLocation(
    SearchLocationEvent event,
    Emitter<SearchLocationState> emit,
  ) async {
    emit(SearchLocationLoading());

    final result = await locator<
        BaseUseCase<List<LocationModel>, CreateLabManagerEntity>
    >(instanceName: 'SearchLocation')(
      event.entity,
    );

    result.fold(
      (failure) {
        emit(SearchLocationFailed(failure.message));
      },
      (locationModel) {
        emit(SearchLocationLoaded(locationModel));
      },
    );
  }

  /// 🔥 Debounce transformer (FIX)
  EventTransformer<T> _debounce<T>(Duration duration) {
    return (events, mapper) {
      return events
          .debounceTime(duration)
          .asyncExpand(mapper);
    };
  }
}