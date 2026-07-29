import 'package:dental_link_dashboard/features/receptionist/data/models/doctor_details/doctor_details_model.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/entities/show_doctors/show_doctor_details_entity.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/api/api_endpoints.dart';
import 'package:dental_link_dashboard/core/auth/auth_token_storage.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/core/network/dio_client.dart';

abstract interface class ShowDoctorDetailsRemoteDataSource {

  Future<DoctorDetailsResponse> getDoctorDetails(
    ShowDoctorDetailsEntity parameters,
  );

}

@Injectable(as: ShowDoctorDetailsRemoteDataSource)
class ShowDoctorDetailsRemoteDataSourceImpl
    implements ShowDoctorDetailsRemoteDataSource {


  const ShowDoctorDetailsRemoteDataSourceImpl(
    this._dioClient,
    this._tokenStorage,
  );



  final DioClient _dioClient;

  final AuthTokenStorage _tokenStorage;



  @override
  Future<DoctorDetailsResponse> getDoctorDetails(

    ShowDoctorDetailsEntity parameters,

  ) async {
    try {
      final response = await _dioClient.dio.get(

        '${ApiEndpoints.showDoctorDetails}/${parameters.doctorId}',

          queryParameters: parameters.toQueryParameters(),

        options: Options(

          headers: {
            'Authorization':'Bearer ${_tokenStorage.token}',
          },
        ),
      );
      return DoctorDetailsResponse.fromJson(
        response.data,
      );
    } on DioException catch(e) {

      throw AppException.fromDioException(e);

    } catch(e) {

      throw AppException(
        message: e.toString(),
      );
    }
  }
}

