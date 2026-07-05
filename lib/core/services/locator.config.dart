// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dental_link_dashboard/core/auth/auth_token_storage.dart'
    as _i825;
import 'package:dental_link_dashboard/core/constants/theme_data/theme_cubit.dart'
    as _i92;
import 'package:dental_link_dashboard/core/navigation/navigation_cubit.dart'
    as _i620;
import 'package:dental_link_dashboard/core/network/dio_client.dart' as _i996;
import 'package:dental_link_dashboard/core/services/injectable_module.dart'
    as _i860;
import 'package:dental_link_dashboard/features/admin/data/datasources/create_lab_manager/create_lab_manager_remote_data_source.dart'
    as _i215;
import 'package:dental_link_dashboard/features/admin/data/datasources/delete_lab_manager/delete_lab_manager_remote_data_source.dart'
    as _i668;
import 'package:dental_link_dashboard/features/admin/data/datasources/edit_lab_manager/edit_lab_manager_remote_data_source.dart'
    as _i832;
import 'package:dental_link_dashboard/features/admin/data/datasources/location/location_remote_data_source.dart'
    as _i351;
import 'package:dental_link_dashboard/features/admin/data/datasources/login/login_remote_data_source.dart'
    as _i1002;
import 'package:dental_link_dashboard/features/admin/data/datasources/manage_labs/labs_remote_data_source.dart'
    as _i301;
import 'package:dental_link_dashboard/features/admin/data/models/location/location_model.dart'
    as _i707;
import 'package:dental_link_dashboard/features/admin/data/repositories/create_lab_manager/create_lab_manager_repository_impl.dart'
    as _i710;
import 'package:dental_link_dashboard/features/admin/data/repositories/delete_lab_manager/delete_lab_manager_repository_impl.dart'
    as _i974;
import 'package:dental_link_dashboard/features/admin/data/repositories/edit_lab_manager_repository_impl.dart'
    as _i494;
import 'package:dental_link_dashboard/features/admin/data/repositories/location/location_repository.dart'
    as _i911;
import 'package:dental_link_dashboard/features/admin/data/repositories/login/login_repository_impl.dart'
    as _i260;
import 'package:dental_link_dashboard/features/admin/data/repositories/login/logout_repository_impl.dart'
    as _i672;
import 'package:dental_link_dashboard/features/admin/data/repositories/manage_labs/labs_repository_impl.dart'
    as _i345;
import 'package:dental_link_dashboard/features/admin/domain/entities/create_lab_manager/create_lab_manager_entity.dart'
    as _i357;
import 'package:dental_link_dashboard/features/admin/domain/repositories/create_lab_manager_repository.dart'
    as _i624;
import 'package:dental_link_dashboard/features/admin/domain/repositories/delete_lab_manager_repository.dart'
    as _i163;
import 'package:dental_link_dashboard/features/admin/domain/repositories/edit_lab_manager_repository.dart'
    as _i797;
import 'package:dental_link_dashboard/features/admin/domain/repositories/labs_repository.dart'
    as _i189;
import 'package:dental_link_dashboard/features/admin/domain/repositories/location/location_base_repository.dart'
    as _i750;
import 'package:dental_link_dashboard/features/admin/domain/repositories/login_repository.dart'
    as _i747;
import 'package:dental_link_dashboard/features/admin/domain/repositories/logout_repository.dart'
    as _i707;
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart'
    as _i203;
import 'package:dental_link_dashboard/features/admin/domain/usecases/create_lab_manager/create_lab_manager_use_case.dart'
    as _i899;
import 'package:dental_link_dashboard/features/admin/domain/usecases/delete_lab_manager/delete_lab_manager_use_case.dart'
    as _i747;
import 'package:dental_link_dashboard/features/admin/domain/usecases/edit_lab_manager/edit_lab_manager_use_case.dart'
    as _i346;
import 'package:dental_link_dashboard/features/admin/domain/usecases/location/reverse_location_use_case.dart'
    as _i370;
import 'package:dental_link_dashboard/features/admin/domain/usecases/location/search_location_use_case.dart'
    as _i532;
import 'package:dental_link_dashboard/features/admin/domain/usecases/login/login_usecase.dart'
    as _i525;
import 'package:dental_link_dashboard/features/admin/domain/usecases/login/logout_usecase.dart'
    as _i687;
import 'package:dental_link_dashboard/features/admin/domain/usecases/manage_labs/get_labs_usecase.dart'
    as _i269;
import 'package:dental_link_dashboard/features/admin/presentation/bloc/labs/create_lab_manager/create_lab_manager_bloc.dart'
    as _i759;
import 'package:dental_link_dashboard/features/admin/presentation/bloc/labs/delete_lab_manager/delete_lab_manager_bloc.dart'
    as _i526;
import 'package:dental_link_dashboard/features/admin/presentation/bloc/labs/edit_lab_manager/edit_lab_manager_bloc.dart'
    as _i844;
import 'package:dental_link_dashboard/features/admin/presentation/bloc/labs/manage_labs/manage_labs_bloc.dart'
    as _i787;
import 'package:dental_link_dashboard/features/admin/presentation/bloc/location/search_location_bloc.dart'
    as _i1000;
import 'package:dental_link_dashboard/features/admin/presentation/bloc/login/login_bloc.dart'
    as _i291;
import 'package:dental_link_dashboard/features/admin/presentation/bloc/logout/logout_bloc.dart'
    as _i557;
import 'package:dental_link_dashboard/features/admin/presentation/cubit/create_lab_manager/create_lab_manager_cubit.dart'
    as _i831;
import 'package:dental_link_dashboard/features/admin/presentation/cubit/edit_lab_manager/edit_lab_manager_cubit.dart'
    as _i85;
import 'package:dental_link_dashboard/features/admin/presentation/cubit/login/login_cubit.dart'
    as _i949;
import 'package:dental_link_dashboard/features/admin/presentation/cubit/manage_labs/manage_labs_cubit.dart'
    as _i9;
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/manage_dep/create_departments/create_departments_remote_data_source.dart'
    as _i705;
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/manage_dep/delete_department/delete_department_remote_data_source.dart'
    as _i194;
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/manage_dep/departments_with_employee/departments_with_employee_remote_data_source.dart'
    as _i414;
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/manage_dep/update_department/update_department_remote_data_source.dart'
    as _i745;
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/manage_employee/create_employee_remote_data_source.dart'
    as _i788;
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/manage_employee/delete_employee_remote_data_source.dart'
    as _i553;
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/manage_employee/update_employee_remote_data_source.dart'
    as _i714;
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/manage_roles/create_role_remote_data_source.dart'
    as _i181;
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/manage_roles/delete_role_remote_data_source.dart'
    as _i569;
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/manage_roles/get_all_permissions_remote_data_source.dart'
    as _i346;
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/manage_roles/get_matrix_roles_and_permissions_remote_data_source.dart'
    as _i677;
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/manage_roles/get_roles_remote_data_source.dart'
    as _i759;
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/manage_roles/update_matrix_roles_and_permissions_remote_data_source.dart'
    as _i1012;
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/show_employee/show_employee_remote_data_source.dart'
    as _i722;
import 'package:dental_link_dashboard/features/lab_manager/data/repositories/manage_dep/create_departments_bulk/create_departments_bulk_repository_impl.dart'
    as _i186;
import 'package:dental_link_dashboard/features/lab_manager/data/repositories/manage_dep/delete_department/delete_department_repository_impl.dart'
    as _i242;
import 'package:dental_link_dashboard/features/lab_manager/data/repositories/manage_dep/departments_with_employee/departments_with_employee_repository_impl.dart'
    as _i760;
import 'package:dental_link_dashboard/features/lab_manager/data/repositories/manage_dep/update_department/update_department_repository_impl.dart'
    as _i915;
import 'package:dental_link_dashboard/features/lab_manager/data/repositories/manage_employee/create_employee_repository_impl.dart'
    as _i536;
import 'package:dental_link_dashboard/features/lab_manager/data/repositories/manage_employee/delete_employee_repository_impl.dart'
    as _i727;
import 'package:dental_link_dashboard/features/lab_manager/data/repositories/manage_employee/update_employee_repository_impl.dart'
    as _i723;
import 'package:dental_link_dashboard/features/lab_manager/data/repositories/manage_roles/create_role_repository_impl.dart'
    as _i140;
import 'package:dental_link_dashboard/features/lab_manager/data/repositories/manage_roles/delete_role_repository_impl.dart'
    as _i858;
import 'package:dental_link_dashboard/features/lab_manager/data/repositories/manage_roles/get_all_permissions_repository_impl.dart'
    as _i696;
import 'package:dental_link_dashboard/features/lab_manager/data/repositories/manage_roles/get_matrix_roles_and_permissions_repository_impl.dart'
    as _i1059;
import 'package:dental_link_dashboard/features/lab_manager/data/repositories/manage_roles/get_roles_repository_impl.dart'
    as _i979;
import 'package:dental_link_dashboard/features/lab_manager/data/repositories/manage_roles/update_matrix_roles_and_permissions_repository_impl.dart'
    as _i37;
import 'package:dental_link_dashboard/features/lab_manager/data/repositories/show_employee/show_employee_repository_impl.dart'
    as _i116;
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/employee/show_employee_repository.dart'
    as _i683;
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_dep/create_departments_repository.dart'
    as _i912;
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_dep/delete_department_repository.dart'
    as _i715;
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_dep/departments_with_employee_repository.dart'
    as _i348;
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_dep/update_department_repository.dart'
    as _i1006;
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_employee/create_employee_repository.dart'
    as _i579;
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_employee/delete_employee_repository.dart'
    as _i322;
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_employee/update_employee_repository.dart'
    as _i1019;
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_roles/create_role_repository.dart'
    as _i432;
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_roles/delete_role_repository.dart'
    as _i25;
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_roles/get_all_permissions_repository.dart'
    as _i1029;
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_roles/get_matrix_roles_and_permissions_repository.dart'
    as _i314;
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_roles/get_roles_repository.dart'
    as _i1004;
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_roles/update_matrix_roles_and_permissions_repository.dart'
    as _i635;
import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/manage_dep/create_departments_use_case.dart'
    as _i390;
import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/manage_dep/delete_department_use_case.dart'
    as _i160;
import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/manage_dep/get_departments_with_employee_usecase.dart'
    as _i709;
import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/manage_dep/update_department_use_case.dart'
    as _i322;
import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/manage_employee/create_employee_usecase.dart'
    as _i46;
import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/manage_employee/delete_employee_use_case.dart'
    as _i1017;
import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/manage_employee/edit_employee_usecase.dart'
    as _i547;
import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/manage_employee/update_employee_usecase.dart'
    as _i71;
import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/manage_roles/create_role_usecase.dart'
    as _i196;
import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/manage_roles/delete_role_use_case.dart'
    as _i1004;
import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/manage_roles/get_all_permissions_usecase.dart'
    as _i375;
import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/manage_roles/get_matrix_roles_and_permissions_usecase.dart'
    as _i741;
import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/manage_roles/get_roles_usecase.dart'
    as _i805;
import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/manage_roles/update_matrix_roles_and_permissions_usecase.dart'
    as _i283;
import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/show_employee/get_show_employee_usecase.dart'
    as _i433;
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_dep/create_departments/create_departments_bloc.dart'
    as _i4;
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_dep/delete_department/delete_department_bloc.dart'
    as _i482;
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_dep/departments_with_employee/departments_with_employee_bloc.dart'
    as _i32;
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_dep/update_department/update_department_bloc.dart'
    as _i709;
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_employee/create_employee/create_employee_bloc.dart'
    as _i659;
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_employee/delete_employee/delete_employee_bloc.dart'
    as _i1025;
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_employee/edit_employee/update_employee_bloc.dart'
    as _i445;
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_employee/roles/roles_bloc.dart'
    as _i1039;
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_employee/show_employee/employee_page_bloc.dart'
    as _i499;
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_roles/create_role/bloc/create_role_bloc.dart'
    as _i386;
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_roles/delete_role/bloc/delete_role_bloc.dart'
    as _i595;
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_roles/get_all_permissions/bloc/get_all_permissions_bloc.dart'
    as _i408;
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_roles/get_matrix_roles_and_permissions/get_matrix_roles_and_permissions_bloc.dart'
    as _i574;
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_roles/update_matrix_roles_and_permissions/update_matrix_roles_and_permissions_bloc.dart'
    as _i606;
import 'package:dental_link_dashboard/features/receptionist/data/datasources/manage_delivery/create_delivery_assignment_remote_data_source.dart'
    as _i250;
import 'package:dental_link_dashboard/features/receptionist/data/datasources/manage_delivery/show_delivery_employees_remote_data_source.dart'
    as _i482;
import 'package:dental_link_dashboard/features/receptionist/data/datasources/manage_orders/print_qr_remote_data_source.dart'
    as _i262;
import 'package:dental_link_dashboard/features/receptionist/data/datasources/manage_orders/show_orders_remote_data_source.dart'
    as _i539;
import 'package:dental_link_dashboard/features/receptionist/data/datasources/manage_orders/update_order_status_remote_data_source.dart'
    as _i200;
import 'package:dental_link_dashboard/features/receptionist/data/repositories/manage_delivery/create_delivery_assignment_repository_impl.dart'
    as _i560;
import 'package:dental_link_dashboard/features/receptionist/data/repositories/manage_delivery/show_delivery_employees_repositrory_impl.dart'
    as _i236;
import 'package:dental_link_dashboard/features/receptionist/data/repositories/manage_orders/print_qr_repository_impl.dart'
    as _i561;
import 'package:dental_link_dashboard/features/receptionist/data/repositories/manage_orders/show_orders_repository_impl.dart'
    as _i955;
import 'package:dental_link_dashboard/features/receptionist/data/repositories/manage_orders/update_order_status_repository_impl.dart'
    as _i572;
import 'package:dental_link_dashboard/features/receptionist/domain/repositories/manage_delivery/create_delivery_assignment_repository.dart'
    as _i321;
import 'package:dental_link_dashboard/features/receptionist/domain/repositories/manage_delivery/show_delivery_employees_repositrory.dart'
    as _i323;
import 'package:dental_link_dashboard/features/receptionist/domain/repositories/manage_orders/print_qr_repository.dart'
    as _i501;
import 'package:dental_link_dashboard/features/receptionist/domain/repositories/manage_orders/show_orders_repository.dart'
    as _i38;
import 'package:dental_link_dashboard/features/receptionist/domain/repositories/manage_orders/update_order_status_repository.dart'
    as _i320;
import 'package:dental_link_dashboard/features/receptionist/domain/usecases/manage_delivery/create_delivery_assignment_usecase.dart'
    as _i186;
import 'package:dental_link_dashboard/features/receptionist/domain/usecases/manage_delivery/show_delivery_employees_usecase.dart'
    as _i610;
import 'package:dental_link_dashboard/features/receptionist/domain/usecases/manage_orders/print_qr_usecase.dart'
    as _i893;
import 'package:dental_link_dashboard/features/receptionist/domain/usecases/manage_orders/show_orders_usecase.dart'
    as _i624;
import 'package:dental_link_dashboard/features/receptionist/domain/usecases/manage_orders/update_order_status_usecase.dart'
    as _i515;
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/manage_delivery/create_delivery_assignment/create_delivery_assignment_bloc.dart'
    as _i978;
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/manage_delivery/show_delivery_employees/show_delivery_employees_bloc.dart'
    as _i564;
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/print_qr/print_qr_bloc.dart'
    as _i169;
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/show_orders/show_orders_bloc.dart'
    as _i645;
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/update_order_status/update_order_status_bloc.dart'
    as _i23;
import 'package:dental_link_dashboard/features/receptionist/presentation/cubit/receptionist_dashboard_cubit.dart'
    as _i236;
import 'package:dental_link_dashboard/l10n/locale_cubit.dart' as _i609;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final injectableModule = _$InjectableModule();
    gh.factory<_i1000.SearchLocationBloc>(() => _i1000.SearchLocationBloc());
    gh.factory<_i831.CreateLabManagerCubit>(
      () => _i831.CreateLabManagerCubit(),
    );
    gh.factory<_i85.EditLabManagerCubit>(() => _i85.EditLabManagerCubit());
    gh.factory<_i949.LoginCubit>(() => _i949.LoginCubit());
    gh.factory<_i9.ManageLabsCubit>(() => _i9.ManageLabsCubit());
    gh.factory<_i236.ReceptionistDashboardCubit>(
      () => _i236.ReceptionistDashboardCubit(),
    );
    gh.singleton<_i996.DioClient>(() => _i996.DioClient());
    await gh.singletonAsync<_i825.AuthTokenStorage>(
      () => injectableModule.authTokenStorage,
      preResolve: true,
    );
    gh.lazySingleton<_i92.ThemeCubit>(() => _i92.ThemeCubit());
    gh.lazySingleton<_i620.NavigationCubit>(() => _i620.NavigationCubit());
    gh.lazySingleton<_i609.LocaleCubit>(() => _i609.LocaleCubit());
    gh.factory<_i553.DeleteEmployeeRemoteDataSource>(
      () => _i553.DeleteEmployeeRemoteDataSourceImpl(
        gh<_i996.DioClient>(),
        gh<_i825.AuthTokenStorage>(),
      ),
    );
    gh.factory<_i1012.UpdateMatrixRolesAndPermissionsRemoteDataSource>(
      () => _i1012.UpdateMatrixRolesAndPermissionsRemoteDataSourceImpl(
        gh<_i996.DioClient>(),
        gh<_i825.AuthTokenStorage>(),
      ),
    );
    gh.factory<_i745.UpdateDepartmentRemoteDataSource>(
      () => _i745.UpdateDepartmentRemoteDataSourceImpl(
        gh<_i996.DioClient>(),
        gh<_i825.AuthTokenStorage>(),
      ),
    );
    gh.factory<_i705.CreateDepartmentsRemoteDataSource>(
      () => _i705.CreateDepartmentsRemoteDataSourceImpl(
        gh<_i996.DioClient>(),
        gh<_i825.AuthTokenStorage>(),
      ),
    );
    gh.factory<_i832.EditLabManagerRemoteDataSource>(
      () => _i832.EditLabManagerRemoteDataSourceImpl(
        gh<_i996.DioClient>(),
        gh<_i825.AuthTokenStorage>(),
      ),
    );
    gh.factory<_i215.CreateLabManagerRemoteDataSource>(
      () => _i215.CreateLabManagerRemoteDataSourceImpl(
        gh<_i996.DioClient>(),
        gh<_i825.AuthTokenStorage>(),
      ),
    );
    gh.factory<_i482.ShowDeliveryEmployeesRemoteDataSource>(
      () => _i482.ShowDeliveryEmployeesRemoteDataSourceImpl(
        gh<_i996.DioClient>(),
        gh<_i825.AuthTokenStorage>(),
      ),
    );
    gh.factory<_i181.CreateRoleRemoteDataSource>(
      () => _i181.CreateRoleRemoteDataSourceImpl(
        gh<_i996.DioClient>(),
        gh<_i825.AuthTokenStorage>(),
      ),
    );
    gh.factory<_i250.CreateDeliveryAssignmentRemoteDataSource>(
      () => _i250.CreateDeliveryAssignmentRemoteDataSourceImpl(
        gh<_i996.DioClient>(),
        gh<_i825.AuthTokenStorage>(),
      ),
    );
    gh.lazySingleton<_i635.UpdateMatrixRolesAndPermissionsRepository>(
      () => _i37.UpdateMatrixRolesAndPermissionsRepositoryImpl(
        gh<_i1012.UpdateMatrixRolesAndPermissionsRemoteDataSource>(),
      ),
    );
    gh.factory<_i912.CreateDepartmentsRepository>(
      () => _i186.CreateDepartmentsRepositoryImpl(
        gh<_i705.CreateDepartmentsRemoteDataSource>(),
      ),
    );
    gh.factory<_i759.GetRolesRemoteDataSource>(
      () => _i759.GetRolesRemoteDataSourceImpl(
        gh<_i996.DioClient>(),
        gh<_i825.AuthTokenStorage>(),
      ),
    );
    gh.factory<_i262.PrintQrRemoteDataSource>(
      () => _i262.PrintQrRemoteDataSourceImpl(
        gh<_i996.DioClient>(),
        gh<_i825.AuthTokenStorage>(),
      ),
    );
    gh.factory<_i346.GetAllPermissionsRemoteDataSource>(
      () => _i346.GetAllPermissionsRemoteDataSourceImpl(
        gh<_i996.DioClient>(),
        gh<_i825.AuthTokenStorage>(),
      ),
    );
    gh.factory<_i351.BaseLocationRemoteDataSource>(
      () => _i351.LocationRemoteDataSource(gh<_i996.DioClient>()),
    );
    gh.factory<_i569.DeleteRoleRemoteDataSource>(
      () => _i569.DeleteRoleRemoteDataSourceImpl(
        gh<_i996.DioClient>(),
        gh<_i825.AuthTokenStorage>(),
      ),
    );
    gh.factory<_i788.CreateEmployeeRemoteDataSource>(
      () => _i788.CreateEmployeeRemoteDataSourceImpl(
        gh<_i996.DioClient>(),
        gh<_i825.AuthTokenStorage>(),
      ),
    );
    gh.factory<_i722.ShowEmployeeRemoteDataSource>(
      () => _i722.ShowEmployeeRemoteDataSourceImpl(
        gh<_i996.DioClient>(),
        gh<_i825.AuthTokenStorage>(),
      ),
    );
    gh.factory<_i200.UpdateOrderStatusRemoteDataSource>(
      () => _i200.UpdateOrderStatusRemoteDataSourceImpl(
        gh<_i996.DioClient>(),
        gh<_i825.AuthTokenStorage>(),
      ),
    );
    gh.factory<_i677.GetMatrixRolesAndPermissionsRemoteDataSource>(
      () => _i677.GetMatrixRolesAndPermissionsRemoteDataSourceImpl(
        gh<_i996.DioClient>(),
        gh<_i825.AuthTokenStorage>(),
      ),
    );
    gh.factory<_i194.DeleteDepartmentRemoteDataSource>(
      () => _i194.DeleteDepartmentRemoteDataSourceImpl(
        gh<_i996.DioClient>(),
        gh<_i825.AuthTokenStorage>(),
      ),
    );
    gh.factory<_i301.LabsRemoteDataSource>(
      () => _i301.LabsRemoteDataSourceImpl(
        gh<_i996.DioClient>(),
        gh<_i825.AuthTokenStorage>(),
      ),
    );
    gh.factory<_i539.ShowOrdersRemoteDataSource>(
      () => _i539.ShowOrdersRemoteDataSourceImpl(
        gh<_i996.DioClient>(),
        gh<_i825.AuthTokenStorage>(),
      ),
    );
    gh.factory<_i1002.LoginRemoteDataSource>(
      () => _i1002.LoginRemoteDataSourceImpl(gh<_i996.DioClient>()),
    );
    gh.factory<_i1006.UpdateDepartmentRepository>(
      () => _i915.UpdateDepartmentRepositoryImpl(
        gh<_i745.UpdateDepartmentRemoteDataSource>(),
      ),
    );
    gh.factory<_i579.CreateEmployeeRepository>(
      () => _i536.CreateEmployeeRepositoryImpl(
        gh<_i788.CreateEmployeeRemoteDataSource>(),
      ),
    );
    gh.factory<_i414.DepartmentsWithEmployeeRemoteDataSource>(
      () => _i414.DepartmentsWithEmployeeRemoteDataSourceImpl(
        gh<_i996.DioClient>(),
        gh<_i825.AuthTokenStorage>(),
      ),
    );
    gh.factory<_i668.DeleteLabManagerRemoteDataSource>(
      () => _i668.DeleteLabManagerRemoteDataSourceImpl(
        gh<_i996.DioClient>(),
        gh<_i825.AuthTokenStorage>(),
      ),
    );
    gh.factory<_i714.UpdateEmployeeRemoteDataSource>(
      () => _i714.UpdateEmployeeRemoteDataSourceImpl(
        gh<_i996.DioClient>(),
        gh<_i825.AuthTokenStorage>(),
      ),
    );
    gh.factory<_i163.DeleteLabManagerRepository>(
      () => _i974.DeleteLabManagerRepositoryImpl(
        gh<_i668.DeleteLabManagerRemoteDataSource>(),
      ),
    );
    gh.factory<_i322.UpdateDepartmentUseCase>(
      () => _i322.UpdateDepartmentUseCase(
        gh<_i1006.UpdateDepartmentRepository>(),
      ),
    );
    gh.factory<_i709.UpdateDepartmentBloc>(
      () => _i709.UpdateDepartmentBloc(
        updateDepartmentUseCase: gh<_i322.UpdateDepartmentUseCase>(),
      ),
    );
    gh.factory<_i707.LogoutRepository>(
      () => _i672.LogoutRepositoryImpl(gh<_i1002.LoginRemoteDataSource>()),
    );
    gh.factory<_i624.CreateLabManagerRepository>(
      () => _i710.CreateLabManagerRepositoryImpl(
        gh<_i215.CreateLabManagerRemoteDataSource>(),
      ),
    );
    gh.factory<_i323.ShowDeliveryEmployeesRepository>(
      () => _i236.ShowDeliveryEmployeesRepositoryImpl(
        gh<_i482.ShowDeliveryEmployeesRemoteDataSource>(),
      ),
    );
    gh.factory<_i683.ShowEmployeeRepository>(
      () => _i116.ShowEmployeeRepositoryImpl(
        gh<_i722.ShowEmployeeRemoteDataSource>(),
      ),
    );
    gh.factory<_i322.DeleteEmployeeRepository>(
      () => _i727.DeleteEmployeeRepositoryImpl(
        gh<_i553.DeleteEmployeeRemoteDataSource>(),
      ),
    );
    gh.factory<_i715.DeleteDepartmentRepository>(
      () => _i242.DeleteDepartmentRepositoryImpl(
        gh<_i194.DeleteDepartmentRemoteDataSource>(),
      ),
    );
    gh.factory<_i189.LabsRepository>(
      () => _i345.LabsRepositoryImpl(gh<_i301.LabsRemoteDataSource>()),
    );
    gh.factory<_i283.UpdateMatrixRolesAndPermissionsUseCase>(
      () => _i283.UpdateMatrixRolesAndPermissionsUseCase(
        gh<_i635.UpdateMatrixRolesAndPermissionsRepository>(),
      ),
    );
    gh.factory<_i501.PrintQrRepository>(
      () => _i561.PrintQrRepositoryImpl(gh<_i262.PrintQrRemoteDataSource>()),
    );
    gh.factory<_i160.DeleteDepartmentUseCase>(
      () =>
          _i160.DeleteDepartmentUseCase(gh<_i715.DeleteDepartmentRepository>()),
    );
    gh.factory<_i321.CreateDeliveryAssignmentRepository>(
      () => _i560.CreateDeliveryAssignmentRepositoryImpl(
        gh<_i250.CreateDeliveryAssignmentRemoteDataSource>(),
      ),
    );
    gh.factory<_i269.GetLabsUseCase>(
      () => _i269.GetLabsUseCase(gh<_i189.LabsRepository>()),
    );
    gh.factory<_i787.ManageLabsBloc>(
      () => _i787.ManageLabsBloc(getLabsUseCase: gh<_i269.GetLabsUseCase>()),
    );
    gh.factory<_i1017.DeleteEmployeeUseCase>(
      () => _i1017.DeleteEmployeeUseCase(gh<_i322.DeleteEmployeeRepository>()),
    );
    gh.factory<_i687.LogoutUseCase>(
      () => _i687.LogoutUseCase(gh<_i707.LogoutRepository>()),
    );
    gh.factory<_i1029.GetAllPermissionsRepository>(
      () => _i696.GetAllPermissionsRepositoryImpl(
        gh<_i346.GetAllPermissionsRemoteDataSource>(),
      ),
    );
    gh.factory<_i899.CreateLabManagerUseCase>(
      () =>
          _i899.CreateLabManagerUseCase(gh<_i624.CreateLabManagerRepository>()),
    );
    gh.factory<_i797.EditLabManagerRepository>(
      () => _i494.EditLabManagerRepositoryImpl(
        gh<_i832.EditLabManagerRemoteDataSource>(),
      ),
    );
    gh.factory<_i747.LoginRepository>(
      () => _i260.LoginRepositoryImpl(gh<_i1002.LoginRemoteDataSource>()),
    );
    gh.factory<_i314.GetMatrixRolesAndPermissionsRepository>(
      () => _i1059.GetMatrixRolesAndPermissionsRepositoryImpl(
        gh<_i677.GetMatrixRolesAndPermissionsRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i432.CreateRoleRepository>(
      () => _i140.CreateRoleRepositoryImpl(
        gh<_i181.CreateRoleRemoteDataSource>(),
      ),
    );
    gh.factory<_i390.CreateDepartmentsUseCase>(
      () => _i390.CreateDepartmentsUseCase(
        gh<_i912.CreateDepartmentsRepository>(),
      ),
    );
    gh.factory<_i1004.GetRolesRepository>(
      () => _i979.GetRolesRepositoryImpl(gh<_i759.GetRolesRemoteDataSource>()),
    );
    gh.factory<_i750.LocationBaseRepository>(
      () => _i911.LocationRepository(gh<_i351.BaseLocationRemoteDataSource>()),
    );
    gh.factory<
      _i203.BaseUseCase<List<_i707.LocationModel>, _i357.CreateLabManagerEntity>
    >(
      () => _i532.SearchLocationUseCase(gh<_i750.LocationBaseRepository>()),
      instanceName: 'SearchLocation',
    );
    gh.factory<_i1025.DeleteEmployeeBloc>(
      () => _i1025.DeleteEmployeeBloc(
        deleteEmployeeUseCase: gh<_i1017.DeleteEmployeeUseCase>(),
      ),
    );
    gh.factory<_i25.DeleteRoleRepository>(
      () => _i858.DeleteRoleRepositoryImpl(
        gh<_i569.DeleteRoleRemoteDataSource>(),
      ),
    );
    gh.factory<_i38.ShowOrdersRepository>(
      () => _i955.ShowOrdersRepositoryImpl(
        gh<_i539.ShowOrdersRemoteDataSource>(),
      ),
    );
    gh.factory<_i482.DeleteDepartmentBloc>(
      () => _i482.DeleteDepartmentBloc(
        deleteDepartmentUseCase: gh<_i160.DeleteDepartmentUseCase>(),
      ),
    );
    gh.factory<_i606.UpdateMatrixRolesAndPermissonsBloc>(
      () => _i606.UpdateMatrixRolesAndPermissonsBloc(
        gh<_i283.UpdateMatrixRolesAndPermissionsUseCase>(),
      ),
    );
    gh.factory<_i196.CreateRoleUseCase>(
      () => _i196.CreateRoleUseCase(gh<_i432.CreateRoleRepository>()),
    );
    gh.factory<_i348.DepartmentsWithEmployeeRepository>(
      () => _i760.DepartmentsWithEmployeeRepositoryImpl(
        gh<_i414.DepartmentsWithEmployeeRemoteDataSource>(),
      ),
    );
    gh.factory<_i893.PrintQrUseCase>(
      () => _i893.PrintQrUseCase(gh<_i501.PrintQrRepository>()),
    );
    gh.factory<_i320.UpdateOrderStatusRepository>(
      () => _i572.UpdateOrderStatusRepositoryImpl(
        gh<_i200.UpdateOrderStatusRemoteDataSource>(),
      ),
    );
    gh.factory<
      _i203.BaseUseCase<_i707.LocationModel, _i357.CreateLabManagerEntity>
    >(
      () => _i370.ReverseLocationUseCase(gh<_i750.LocationBaseRepository>()),
      instanceName: 'ReverseLocation',
    );
    gh.factory<_i747.DeleteLabManagerUseCase>(
      () =>
          _i747.DeleteLabManagerUseCase(gh<_i163.DeleteLabManagerRepository>()),
    );
    gh.factory<_i46.CreateEmployeeUseCase>(
      () => _i46.CreateEmployeeUseCase(gh<_i579.CreateEmployeeRepository>()),
    );
    gh.factory<_i610.ShowDeliveryEmployeesUsecase>(
      () => _i610.ShowDeliveryEmployeesUsecase(
        gh<_i323.ShowDeliveryEmployeesRepository>(),
      ),
    );
    gh.factory<_i805.GetRolesUseCase>(
      () => _i805.GetRolesUseCase(gh<_i1004.GetRolesRepository>()),
    );
    gh.factory<_i515.UpdateOrderStatusUseCase>(
      () => _i515.UpdateOrderStatusUseCase(
        gh<_i320.UpdateOrderStatusRepository>(),
      ),
    );
    gh.factory<_i1019.UpdateEmployeeRepository>(
      () => _i723.UpdateEmployeeRepositoryImpl(
        gh<_i714.UpdateEmployeeRemoteDataSource>(),
      ),
    );
    gh.factory<_i525.LoginUseCase>(
      () => _i525.LoginUseCase(gh<_i747.LoginRepository>()),
    );
    gh.factory<_i759.CreateLabManagerBloc>(
      () => _i759.CreateLabManagerBloc(
        createLabManagerUseCase: gh<_i899.CreateLabManagerUseCase>(),
      ),
    );
    gh.factory<_i386.CreateRoleBloc>(
      () => _i386.CreateRoleBloc(gh<_i196.CreateRoleUseCase>()),
    );
    gh.factory<_i433.GetShowEmployeeUseCase>(
      () => _i433.GetShowEmployeeUseCase(gh<_i683.ShowEmployeeRepository>()),
    );
    gh.factory<_i709.GetDepartmentsWithEmployeeUseCase>(
      () => _i709.GetDepartmentsWithEmployeeUseCase(
        gh<_i348.DepartmentsWithEmployeeRepository>(),
      ),
    );
    gh.factory<_i375.GetAllPermissionsUseCase>(
      () => _i375.GetAllPermissionsUseCase(
        gh<_i1029.GetAllPermissionsRepository>(),
      ),
    );
    gh.factory<_i1004.DeleteRoleUseCase>(
      () => _i1004.DeleteRoleUseCase(gh<_i25.DeleteRoleRepository>()),
    );
    gh.factory<_i624.ShowOrdersUseCase>(
      () => _i624.ShowOrdersUseCase(gh<_i38.ShowOrdersRepository>()),
    );
    gh.factory<_i526.DeleteLabManagerBloc>(
      () => _i526.DeleteLabManagerBloc(
        deleteLabManagerUseCase: gh<_i747.DeleteLabManagerUseCase>(),
      ),
    );
    gh.factory<_i186.CreateDeliveryAssignmentUsecase>(
      () => _i186.CreateDeliveryAssignmentUsecase(
        gh<_i321.CreateDeliveryAssignmentRepository>(),
      ),
    );
    gh.factory<_i557.LogoutBloc>(
      () => _i557.LogoutBloc(logoutUseCase: gh<_i687.LogoutUseCase>()),
    );
    gh.factory<_i346.EditLabManagerUseCase>(
      () => _i346.EditLabManagerUseCase(gh<_i797.EditLabManagerRepository>()),
    );
    gh.factory<_i659.CreateEmployeeBloc>(
      () => _i659.CreateEmployeeBloc(
        createEmployeeUseCase: gh<_i46.CreateEmployeeUseCase>(),
      ),
    );
    gh.factory<_i741.GetMatrixRolesAndPermissionsUseCase>(
      () => _i741.GetMatrixRolesAndPermissionsUseCase(
        gh<_i314.GetMatrixRolesAndPermissionsRepository>(),
      ),
    );
    gh.factory<_i564.ShowDeliveryEmployeesBloc>(
      () => _i564.ShowDeliveryEmployeesBloc(
        gh<_i610.ShowDeliveryEmployeesUsecase>(),
      ),
    );
    gh.factory<_i4.CreateDepartmentsBloc>(
      () => _i4.CreateDepartmentsBloc(
        createDepartmentsUseCase: gh<_i390.CreateDepartmentsUseCase>(),
      ),
    );
    gh.factory<_i291.LoginBloc>(
      () => _i291.LoginBloc(loginUseCase: gh<_i525.LoginUseCase>()),
    );
    gh.factory<_i595.DeleteRoleBloc>(
      () => _i595.DeleteRoleBloc(gh<_i1004.DeleteRoleUseCase>()),
    );
    gh.factory<_i408.GetAllPermissionsBloc>(
      () => _i408.GetAllPermissionsBloc(gh<_i375.GetAllPermissionsUseCase>()),
    );
    gh.factory<_i645.ShowOrdersBloc>(
      () => _i645.ShowOrdersBloc(gh<_i624.ShowOrdersUseCase>()),
    );
    gh.factoryParam<_i499.EmployeePageBloc, int, String>(
      (departmentId, departmentName) => _i499.EmployeePageBloc(
        getShowEmployeeUseCase: gh<_i433.GetShowEmployeeUseCase>(),
        departmentId: departmentId,
        departmentName: departmentName,
      ),
    );
    gh.factory<_i1039.RolesBloc>(
      () => _i1039.RolesBloc(getRolesUseCase: gh<_i805.GetRolesUseCase>()),
    );
    gh.factory<_i169.PrintQrBloc>(
      () => _i169.PrintQrBloc(gh<_i893.PrintQrUseCase>()),
    );
    gh.factory<_i23.UpdateOrderStatusBloc>(
      () => _i23.UpdateOrderStatusBloc(gh<_i515.UpdateOrderStatusUseCase>()),
    );
    gh.factory<_i574.GetMatrixRolesAndPermissionsBloc>(
      () => _i574.GetMatrixRolesAndPermissionsBloc(
        gh<_i741.GetMatrixRolesAndPermissionsUseCase>(),
      ),
    );
    gh.factory<_i547.UpdateEmployeeUseCase>(
      () => _i547.UpdateEmployeeUseCase(gh<_i1019.UpdateEmployeeRepository>()),
    );
    gh.factory<_i71.UpdateEmployeeUseCase>(
      () => _i71.UpdateEmployeeUseCase(gh<_i1019.UpdateEmployeeRepository>()),
    );
    gh.factory<_i978.CreateDeliveryAssignmentBloc>(
      () => _i978.CreateDeliveryAssignmentBloc(
        gh<_i186.CreateDeliveryAssignmentUsecase>(),
      ),
    );
    gh.factory<_i32.DepartmentsWithEmployeeBloc>(
      () => _i32.DepartmentsWithEmployeeBloc(
        getDepartmentsWithEmployeeUseCase:
            gh<_i709.GetDepartmentsWithEmployeeUseCase>(),
      ),
    );
    gh.factory<_i844.EditLabManagerBloc>(
      () => _i844.EditLabManagerBloc(
        editLabManagerUseCase: gh<_i346.EditLabManagerUseCase>(),
      ),
    );
    gh.factory<_i445.UpdateEmployeeBloc>(
      () => _i445.UpdateEmployeeBloc(
        updateEmployeeUseCase: gh<_i71.UpdateEmployeeUseCase>(),
      ),
    );
    return this;
  }
}

class _$InjectableModule extends _i860.InjectableModule {}
