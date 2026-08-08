import 'package:dental_link_dashboard/features/lab_manager/domain/entities/manage_portfolio/update_portfolio_entity.dart';
import 'package:equatable/equatable.dart';

abstract class UpdatePortfolioEvent extends Equatable {
  const UpdatePortfolioEvent();

  @override
  List<Object?> get props => [];
}

class UpdatePortfolioRequested extends UpdatePortfolioEvent {
  const UpdatePortfolioRequested(this.parameters);

  final UpdatePortfolioEntity parameters;

  @override
  List<Object?> get props => [parameters];
}

class UpdatePortfolioReset extends UpdatePortfolioEvent {
  const UpdatePortfolioReset();
}