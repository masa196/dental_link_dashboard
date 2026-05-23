part of 'search_location_bloc.dart';

sealed class SearchLocationState extends Equatable {

  const SearchLocationState();
}

final class SearchLocationInitial extends SearchLocationState {
  @override
  List<Object?> get props => [];
}
final class SearchLocationLoaded extends SearchLocationState {

  final List<LocationModel>model;

  const SearchLocationLoaded(this.model);

  @override
  List<Object?> get props => [model];
}
final class SearchLocationLoading extends SearchLocationState {
  @override
  List<Object?> get props => [];
}
final class SearchLocationFailed extends SearchLocationState {
  final String message;

  const SearchLocationFailed(this.message);
  @override
  List<Object?> get props => [message];
}