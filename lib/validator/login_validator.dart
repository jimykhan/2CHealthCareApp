class LoginValidator {
  static bool validEmail(String text) {
    RegExp exp = RegExp('^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+\$');
    return exp.hasMatch(text);
  }

  static bool validNumber(String text) {
    return text.length > 8;
  }

  static bool validPassword(String text) {
    return text.length > 0;
  }

  static bool validUserName(String text) {
    return text.length > 0;
  }

  static bool validConformPassword(String password, String conform) {
    return password == conform;
  }

}