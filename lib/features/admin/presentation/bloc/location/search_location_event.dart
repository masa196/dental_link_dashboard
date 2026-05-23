part of 'search_location_bloc.dart';

sealed class ISearchLocationEvent extends Equatable {
  const ISearchLocationEvent();
}
final class SearchLocationEvent extends ISearchLocationEvent{

  final CreateLabManagerEntity entity;


  const SearchLocationEvent(this.entity);

  @override

  List<Object?> get props => [entity];
}