// core/utils/app_validators.dart

class AppValidators {
  static String? validateEmpty(String? value, String errorMsg) {
    if (value == null || value.trim().isEmpty) {
      return errorMsg;
    }
    return null;
  }

  static String? validateEmail(
    String? value,
    String requiredMsg,
    String invalidMsg,
  ) {
    if (value == null || value.trim().isEmpty) {
      return requiredMsg;
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');
    if (!emailRegExp.hasMatch(value.trim())) {
      return invalidMsg;
    }
    return null;
  }

  static String? validatePhone(
    String? value,
    String requiredMsg,
    String digitsOnlyMsg,
  ) {
    if (value == null || value.trim().isEmpty) {
      return requiredMsg;
    }
    final phoneRegExp = RegExp(r'^[0-9]+$');
    if (!phoneRegExp.hasMatch(value.trim())) {
      return digitsOnlyMsg;
    }
    return null;
  }

  static String? validatePassword(
    String? value,
    String requiredMsg,
    String shortMsg,
  ) {
    if (value == null || value.isEmpty) {
      return requiredMsg;
    }
    if (value.length < 8) {
      return shortMsg;
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? password,
    String? confirmPassword,
    String requiredMsg,
    String notMatchMsg,
  ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return requiredMsg;
    }
    if (password != confirmPassword) {
      return notMatchMsg;
    }
    return null;
  }
}
