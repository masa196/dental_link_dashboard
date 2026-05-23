import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dental_link_dashboard/features/lab_manager/presentation/widgets/department_snackbar_helper.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());

  final formKey = GlobalKey<FormState>();

  /// Controllers
  final phoneCtrl = TextEditingController(text: "+971 50 123 4567");
  final emailCtrl = TextEditingController(
    text: "a.almansouri@labos.clinical.ae",
  );
  final passwordCtrl = TextEditingController();

  final nameCtrl = TextEditingController(text: "أحمد محمد المنصوري");
  final birthCtrl = TextEditingController(text: "12 مايو 1985");
  final joinCtrl = TextEditingController(text: "01 يناير 2020");

  void focusField(String? fieldKey) {
    emit(state.copyWith(focusedField: fieldKey));
  }

  void updateField(String fieldKey, String value) {
    switch (fieldKey) {
      case 'phone':
        phoneCtrl.text = value;
        break;
      case 'email':
        emailCtrl.text = value;
        break;
      case 'password':
        passwordCtrl.text = value;
        break;
      case 'name':
        nameCtrl.text = value;
        break;
      case 'birthDate':
        birthCtrl.text = value;
        break;
      case 'joinDate':
        joinCtrl.text = value;
        break;
    }
  }

  Future<void> submit(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    emit(state.copyWith(isSubmitting: true));

    await Future.delayed(const Duration(seconds: 1));

    final data = {
      "phone": phoneCtrl.text,
      "email": emailCtrl.text,
      "password": passwordCtrl.text,
      "name": nameCtrl.text,
      "birthDate": birthCtrl.text,
      "joinDate": joinCtrl.text,
    };

    debugPrint("FORM DATA: $data");

    emit(state.copyWith(isSubmitting: false));

    AppSnackbarHelper.showSuccess(
      context,
      title: 'نجاح',
      message: 'تم حفظ البيانات بنجاح',
    );
  }

  @override
  Future<void> close() {
    phoneCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
    nameCtrl.dispose();
    birthCtrl.dispose();
    joinCtrl.dispose();
    return super.close();
  }
}
