import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';


abstract class BaseUseCase<T,Parameters>{
  Future<Either<AppFailure,T>> call(Parameters parameters);
}
class NoParameters extends Equatable{
  const NoParameters();

  @override
  List<Object?> get props => [];

}