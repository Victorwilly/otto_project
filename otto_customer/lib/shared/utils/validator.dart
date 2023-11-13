// ignore_for_file: curly_braces_in_flow_control_structures

import 'constants.dart';
import 'utils.dart';

class EmailValidator {
  static String? validateEmail(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return emptyEmailField;
      }
      // Regex for email validation
      RegExp regExp = RegExp(emailRegexThree);
      if (regExp.hasMatch(value)) {
        return null;
      }
      return invalidEmailField;
    } else {
      return null;
    }
  }

  // static String? validateEmail(String? value) {
  //   String pattern =
  //       r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
  //       r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
  //       r"{0,253}[a-zA-Z0-9])?)*$";
  //   RegExp regex = RegExp(pattern);
  //   if (value == null || value.isEmpty || !regex.hasMatch(value)) {
  //     return invalidEmailField;
  //   } else {
  //     return null;
  //   }
  // }
}

class PasswordValidator {
  static bool validateStructure(String? value) {
    //allows _ as part of special character
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[a-zA-Z0-9_\-=@,\.;]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value!);
  }

  static String? passwordvalidator(String? str) {
    if (str!.isEmpty) return 'This field can not be empty';
    //<<<<<< comment out to use rght password validation
    if (!FormUtils.hasSpecialCharacters(str))
      return 'Password must have a special character';
    if (!FormUtils.hasMinLength(str))
      return 'Password must have a minimum of 8 characters';
    if (!FormUtils.hasUppercase(str)) return 'Password must have a Upper Case';
    if (!FormUtils.hasDigits(str)) return 'Password must have a digit';

    return null;
  }

  static String? validatePassword(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return emptyPasswordField;
      }

      if (value.length < 8) {
        return passwordLengthError;
      }

      if (!validateStructure(value)) {
        return "Please enter valid password. (Min. 1 upper case \nMin. 1 lowercase \nMin. 1 Numeric Number \nMinimum 1 Special Character( ! @ # \$ & * ~ )";
      }
    } else {
      return null;
    }
    return null;
  }

  static String? validateLoginPassword(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return emptyPasswordField;
      }

      if (value.length < 8) {
        return passwordLengthError;
      }
    } else {
      return null;
    }
    return null;
  }
}

class UsernameValidator {
  static String? validateUsername(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return emptyUsernameField;
      }

      if (value.length < 6) {
        return usernameLengthError;
      }
    } else {
      return null;
    }

    return null;
  }
}

class FieldValidator {
  static String? validate(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return emptyTextField;
      }
    } else {
      return null;
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return emptyTextField;
      }
      if (value.length < 11 || value.length > 11) {
        return phoneNumberLengthError;
      }
    } else {
      return null;
    }

    return null;
  }

  static String? validateOtp(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return emptyTextField;
      }
      // if (value.length < 4 || value.length > 8) {
      if (value.length < 4) {
        return otpLengthError;
      }
    } else {
      return null;
    }

    return null;
  }

  static String? validateMessage(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return emptyTextField;
      }
      if (value.length < 10) {
        return 'Kindly give a descriptive message';
      }
    } else {
      return null;
    }

    return null;
  }

  // validateEmail(String value) {
  //   String pattern =
  //       r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
  //       r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
  //       r"{0,253}[a-zA-Z0-9])?)*$";
  //   RegExp regex = RegExp(pattern);
  //   // ignore: unnecessary_null_comparison
  //   if (value == null || value.isEmpty || !regex.hasMatch(value)) {
  //     return invalidEmailField;
  //   } else {

  //   }
  // }
}
