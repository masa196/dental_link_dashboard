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
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/manage_dep/create_departments_bulk/create_departments_bulk_remote_data_source.dart'
    as _i338;
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/manage_dep/delete_department/delete_department_remote_data_source.dart'
    as _i137;
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/manage_dep/departments_with_employee/departments_with_employee_remote_data_source.dart'
    as _i793;
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/show_employee/show_employee_remote_data_source.dart'
    as _i722;
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/manage_dep/update_department/update_department_remote_data_source.dart'
    as _i774;
import 'package:dental_link_dashboard/features/lab_manager/data/repositories/manage_dep/create_departments_bulk/create_departments_bulk_repository_impl.dart'
    as _i448;
import 'package:dental_link_dashboard/features/lab_manager/data/repositories/manage_dep/delete_department/delete_department_repository_impl.dart'
    as _i757;
import 'package:dental_link_dashboard/features/lab_manager/data/repositories/manage_dep/departments_with_employee/departments_with_employee_repository_impl.dart'
    as _i977;
import 'package:dental_link_dashboard/features/lab_manager/data/repositories/show_employee/show_employee_repository_impl.dart'
    as _i116;
import 'package:dental_link_dashboard/features/lab_manager/data/repositories/manage_dep/update_department/update_department_repository_impl.dart'
    as _i253;
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/departments_with_employee/create_departments_bulk_repository.dart'
    as _i1028;
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/departments_with_employee/delete_department_repository.dart'
    as _i149;
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/departments_with_employee/departments_with_employee_repository.dart'
    as _i610;
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/departments_with_employee/show_employee_repository.dart'
    as _i438;
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/departments_with_employee/update_department_repository.dart'
    as _i373;
import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/create_departments_bulk/create_departments_bulk_use_case.dart'
    as _i591;
import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/delete_department/delete_department_use_case.dart'
    as _i341;
import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/departments_with_employee/get_departments_with_employee_usecase.dart'
    as _i166;
import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/show_employee/get_show_employee_usecase.dart'
    as _i433;
import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/update_department/update_department_use_case.dart'
    as _i994;
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_dep/create_departments/create_departments_bloc.dart'
    as _i4;
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_dep/delete_department/delete_department_bloc.dart'
    as _i482;
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_dep/departments_with_employee/departments_with_employee_bloc.dart'
    as _i32;
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_dep/update_department/update_department_bloc.dart'
    as _i709;
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
    gh.singleton<_i996.DioClient>(() => _i996.DioClient());
    await gh.singletonAsync<_i825.AuthTokenStorage>(
      () => injectableModule.authTokenStorage,
      preResolve: true,
    );
    gh.lazySingleton<_i92.ThemeCubit>(() => _i92.ThemeCubit());
    gh.lazySingleton<_i620.NavigationCubit>(() => _i620.NavigationCubit());
    gh.lazySingleton<_i609.LocaleCubit>(() => _i609.LocaleCubit());
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
    gh.factory<_i351.BaseLocationRemoteDataSource>(
      () => _i351.LocationRemoteDataSource(gh<_i996.DioClient>()),
    );
    gh.factory<_i722.ShowEmployeeRemoteDataSource>(
      () => _i722.ShowEmployeeRemoteDataSourceImpl(
        gh<_i996.DioClient>(),
        gh<_i825.AuthTokenStorage>(),
      ),
    );
    gh.factory<_i774.UpdateDepartmentRemoteDataSource>(
      () => _i774.UpdateDepartmentRemoteDataSourceImpl(
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
    gh.factory<_i338.CreateDepartmentsBulkRemoteDataSource>(
      () => _i338.CreateDepartmentsBulkRemoteDataSourceImpl(
        gh<_i996.DioClient>(),
        gh<_i825.AuthTokenStorage>(),
      ),
    );
    gh.factory<_i1002.LoginRemoteDataSource>(
      () => _i1002.LoginRemoteDataSourceImpl(gh<_i996.DioClient>()),
    );
    gh.factory<_i668.DeleteLabManagerRemoteDataSource>(
      () => _i668.DeleteLabManagerRemoteDataSourceImpl(
        gh<_i996.DioClient>(),
        gh<_i825.AuthTokenStorage>(),
      ),
    );
    gh.factory<_i793.DepartmentsWithEmployeeRemoteDataSource>(
      () => _i793.DepartmentsWithEmployeeRemoteDataSourceImpl(
        gh<_i996.DioClient>(),
        gh<_i825.AuthTokenStorage>(),
      ),
    );
    gh.factory<_i137.DeleteDepartmentRemoteDataSource>(
      () => _i137.DeleteDepartmentRemoteDataSourceImpl(
        gh<_i996.DioClient>(),
        gh<_i825.AuthTokenStorage>(),
      ),
    );
    gh.factory<_i163.DeleteLabManagerRepository>(
      () => _i974.DeleteLabManagerRepositoryImpl(
        gh<_i668.DeleteLabManagerRemoteDataSource>(),
      ),
    );
    gh.factory<_i707.LogoutRepository>(
      () => _i672.LogoutRepositoryImpl(gh<_i1002.LoginRemoteDataSource>()),
    );
    gh.factory<_i438.ShowEmployeeRepository>(
      () => _i116.ShowEmployeeRepositoryImpl(
        gh<_i722.ShowEmployeeRemoteDataSource>(),
      ),
    );
    gh.factory<_i624.CreateLabManagerRepository>(
      () => _i710.CreateLabManagerRepositoryImpl(
        gh<_i215.CreateLabManagerRemoteDataSource>(),
      ),
    );
    gh.factory<_i373.UpdateDepartmentRepository>(
      () => _i253.UpdateDepartmentRepositoryImpl(
        gh<_i774.UpdateDepartmentRemoteDataSource>(),
      ),
    );
    gh.factory<_i189.LabsRepository>(
      () => _i345.LabsRepositoryImpl(gh<_i301.LabsRemoteDataSource>()),
    );
    gh.factory<_i149.DeleteDepartmentRepository>(
      () => _i757.DeleteDepartmentRepositoryImpl(
        gh<_i137.DeleteDepartmentRemoteDataSource>(),
      ),
    );
    gh.factory<_i1028.CreateDepartmentsBulkRepository>(
      () => _i448.CreateDepartmentsBulkRepositoryImpl(
        gh<_i338.CreateDepartmentsBulkRemoteDataSource>(),
      ),
    );
    gh.factory<_i610.DepartmentsWithEmployeeRepository>(
      () => _i977.DepartmentsWithEmployeeRepositoryImpl(
        gh<_i793.DepartmentsWithEmployeeRemoteDataSource>(),
      ),
    );
    gh.factory<_i269.GetLabsUseCase>(
      () => _i269.GetLabsUseCase(gh<_i189.LabsRepository>()),
    );
    gh.factory<_i787.ManageLabsBloc>(
      () => _i787.ManageLabsBloc(getLabsUseCase: gh<_i269.GetLabsUseCase>()),
    );
    gh.factory<_i591.CreateDepartmentsBulkUseCase>(
      () => _i591.CreateDepartmentsBulkUseCase(
        gh<_i1028.CreateDepartmentsBulkRepository>(),
      ),
    );
    gh.factory<_i687.LogoutUseCase>(
      () => _i687.LogoutUseCase(gh<_i707.LogoutRepository>()),
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
    gh.factory<_i433.GetShowEmployeeUseCase>(
      () => _i433.GetShowEmployeeUseCase(gh<_i438.ShowEmployeeRepository>()),
    );
    gh.factory<_i747.LoginRepository>(
      () => _i260.LoginRepositoryImpl(gh<_i1002.LoginRemoteDataSource>()),
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
    gh.factory<_i994.UpdateDepartmentUseCase>(
      () =>
          _i994.UpdateDepartmentUseCase(gh<_i373.UpdateDepartmentRepository>()),
    );
    gh.factory<_i341.DeleteDepartmentUseCase>(
      () =>
          _i341.DeleteDepartmentUseCase(gh<_i149.DeleteDepartmentRepository>()),
    );
    gh.factory<_i4.CreateDepartmentsBulkBloc>(
      () => _i4.CreateDepartmentsBulkBloc(
        createDepartmentsBulkUseCase: gh<_i591.CreateDepartmentsBulkUseCase>(),
      ),
    );
    gh.factory<_i525.LoginUseCase>(
      () => _i525.LoginUseCase(gh<_i747.LoginRepository>()),
    );
    gh.factory<_i166.GetDepartmentsWithEmployeeUseCase>(
      () => _i166.GetDepartmentsWithEmployeeUseCase(
        gh<_i610.DepartmentsWithEmployeeRepository>(),
      ),
    );
    gh.factory<_i759.CreateLabManagerBloc>(
      () => _i759.CreateLabManagerBloc(
        createLabManagerUseCase: gh<_i899.CreateLabManagerUseCase>(),
      ),
    );
    gh.factory<_i32.DepartmentsWithEmployeeBloc>(
      () => _i32.DepartmentsWithEmployeeBloc(
        getDepartmentsWithEmployeeUseCase:
            gh<_i166.GetDepartmentsWithEmployeeUseCase>(),
      ),
    );
    gh.factory<_i709.UpdateDepartmentBloc>(
      () => _i709.UpdateDepartmentBloc(
        updateDepartmentUseCase: gh<_i994.UpdateDepartmentUseCase>(),
      ),
    );
    gh.factory<_i482.DeleteDepartmentBloc>(
      () => _i482.DeleteDepartmentBloc(
        deleteDepartmentUseCase: gh<_i341.DeleteDepartmentUseCase>(),
      ),
    );
    gh.factory<_i526.DeleteLabManagerBloc>(
      () => _i526.DeleteLabManagerBloc(
        deleteLabManagerUseCase: gh<_i747.DeleteLabManagerUseCase>(),
      ),
    );
    gh.factory<_i557.LogoutBloc>(
      () => _i557.LogoutBloc(logoutUseCase: gh<_i687.LogoutUseCase>()),
    );
    gh.factory<_i346.EditLabManagerUseCase>(
      () => _i346.EditLabManagerUseCase(gh<_i797.EditLabManagerRepository>()),
    );
    gh.factory<_i291.LoginBloc>(
      () => _i291.LoginBloc(loginUseCase: gh<_i525.LoginUseCase>()),
    );
    gh.factory<_i844.EditLabManagerBloc>(
      () => _i844.EditLabManagerBloc(
        editLabManagerUseCase: gh<_i346.EditLabManagerUseCase>(),
      ),
    );
    return this;
  }
}

class _$InjectableModule extends _i860.InjectableModule {}
