import 'package:dental_link_dashboard/features/receptionist/domain/entities/show_doctors/show_doctor_details_entity.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/usecases/show_doctors/show_doctor_details_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'show_doctor_details_event.dart';
import 'show_doctor_details_state.dart';



@injectable
class ShowDoctorDetailsBloc extends Bloc< ShowDoctorDetailsEvent,ShowDoctorDetailsState> {

  ShowDoctorDetailsBloc(
    this._usecase,
  )
      : super(
          const ShowDoctorDetailsState(),
        ) {


    on<ShowDoctorDetailsRequested>(
      _onRequested,
    );


    on<ShowDoctorOrdersStatusChanged>(
      _onStatusChanged,
    );


    on<ShowDoctorDetailsRefresh>(
      _onRefresh,
    );

  }

  final ShowDoctorDetailsUsecase _usecase;

  Future<void> _onRequested(

    ShowDoctorDetailsRequested event,

    Emitter<ShowDoctorDetailsState> emit,

  ) async {


    emit(

      state.copyWith(

        isLoadingDoctor: true,

        isLoadingOrders: true,

        failure: null,

        doctorId: event.doctorId,

        currentStatus: event.status,

      ),

    );



    await _loadDoctor(

      event,

      emit,

      isFirstLoad: true,

    );

  }





  Future<void> _onStatusChanged(

    ShowDoctorOrdersStatusChanged event,

    Emitter<ShowDoctorDetailsState> emit,

  ) async {


    if(state.doctorId == null){

      return;

    }



    final request =
        ShowDoctorDetailsRequested(

          doctorId: state.doctorId!,

          status: event.status,

          page: 1,

        );



    emit(

      state.copyWith(

        isLoadingOrders: true,

        currentStatus: event.status,

      ),

    );



    await _loadDoctor(

      request,

      emit,

      isFirstLoad: false,

    );

  }





  Future<void> _loadDoctor(

    ShowDoctorDetailsRequested event,

    Emitter<ShowDoctorDetailsState> emit, {

    required bool isFirstLoad,

  }) async {


    final result = await _usecase(

      ShowDoctorDetailsEntity(

        doctorId: event.doctorId,

        status: event.status,

        page: event.page,

        perPage: event.perPage,

      ),

    );



    result.fold(

      (failure) {


        emit(

          state.copyWith(

            isLoadingDoctor: false,

            isLoadingOrders: false,

            failure: failure,

          ),

        );


      },


      (response) {


        final data = response.data;



        if(data == null){

          return;

        }



        emit(

          state.copyWith(

            doctorInfo:

                isFirstLoad

                ? data

                : state.doctorInfo,



            orders:

                data.orders ?? [],



            pagination:

                data.pagination,



            currentPage:

                data.pagination?.currentPage ?? 1,



            lastPage:

                data.pagination?.lastPage ?? 1,



            isLoadingDoctor: false,

            isLoadingOrders: false,



            currentStatus:

                event.status,

          ),

        );


      },

    );


  }





  Future<void> _onRefresh(

    ShowDoctorDetailsRefresh event,

    Emitter<ShowDoctorDetailsState> emit,

  ) async {


    if(state.doctorId == null){

      return;

    }



    add(

      ShowDoctorDetailsRequested(

        doctorId: state.doctorId!,

        status: state.currentStatus,

        page: state.currentPage,

      ),

    );


  }



}