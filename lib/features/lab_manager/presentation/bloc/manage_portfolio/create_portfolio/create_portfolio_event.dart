import 'package:dental_link_dashboard/features/lab_manager/domain/entities/manage_portfolio/create_portfolio_entity.dart';
import 'package:equatable/equatable.dart';

abstract class CreatePortfolioEvent extends Equatable {
  const CreatePortfolioEvent();

  @override
  List<Object?> get props => [];
}

class CreatePortfolioRequested extends CreatePortfolioEvent {
  const CreatePortfolioRequested(this.parameters);

  final CreatePortfolioEntity parameters;

  @override
  List<Object?> get props => [parameters];
}

class CreatePortfolioReset extends CreatePortfolioEvent {
  const CreatePortfolioReset();
}