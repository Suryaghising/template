import '../../constants/app_strings.dart';

abstract class FormValidationService {
  String? validateEmail(String email);

  String? validatePassword(String password);

  String? validateFirstName(String firstName);

  String? validateLastName(String lastName);
}

class FormValidationServiceImpl implements FormValidationService {
  @override
  String? validateEmail(String email) {
    if (email.isEmpty) {
      return AppStrings.emailIsRequired;
    } else if (!email.contains('@')) {
      return AppStrings.invalidEmail;
    }
    return null;
  }

  @override
  String? validatePassword(String password) {
    if (password.isEmpty) {
      return AppStrings.passwordIsRequired;
    } else if (password.length < 6) {
      return AppStrings.passwordLength;
    }
    return null;
  }

  @override
  String? validateFirstName(String firstName) {
    if (firstName.isEmpty) {
      return AppStrings.firstNameIsRequired;
    }
    return null;
  }

  @override
  String? validateLastName(String lastName) {
    if (lastName.isEmpty) {
      return AppStrings.lastNameIsRequired;
    }
    return null;
  }
}
