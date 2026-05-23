import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

enum AppDestination { login, manageLabs, profile }

@lazySingleton
class NavigationCubit extends Cubit<AppDestination> {
  NavigationCubit() : super(AppDestination.login);

  void startAppAfterLogin() {
    emit(AppDestination.manageLabs);
  }

  void goToLogin() => emit(AppDestination.login);

  void goToManageLabs() => emit(AppDestination.manageLabs);

  void goToProfile() => emit(AppDestination.profile);
}
