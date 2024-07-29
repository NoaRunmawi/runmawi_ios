class Validators {
  static String? validateEmail(String value, String? emailRequiredMessage, String? validEmailMessage,) {
    if (value.isEmpty) {
      return emailRequiredMessage;
    } else if (!RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)"
            r"*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+"
            r"[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(value)) {
      return validEmailMessage;
    } else {
      return null;
    }
  }
  static String? isValueEntered(String value) {
    if (value.isEmpty) {
      return "Please Enter Email/Mobile";
    }
    return null;
  }

  static bool isValidEmail(String value) {
    if (value.isEmpty) {
      return false;
    }
    final pattern =
        RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)"
            r"*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+"
            r"[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
    return pattern.hasMatch(value);
  }
  static String? isValidName(String value) {
    final pattern = RegExp(r'^[a-zA-Z ]+$');
    if (value.isEmpty) {
      return "Please Enter Name";
    }
    else if(!pattern.hasMatch(value))
      {
        return "Please Enter Valid Name";
      }
    else{
      return null;
    }
  }
  static String? isCorrectMobileNumber(String value) {
    final pattern = RegExp(r'^[0-9]+$');
    if (value.isEmpty) {
      return "Please Enter Mobile Number";
    }
   else if(!pattern.hasMatch(value))
      {
        return "Please Enter Vaild Mobile Number";
      }
 else {
   return null;
    }

  }
}
