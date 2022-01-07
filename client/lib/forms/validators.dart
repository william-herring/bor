/*
validators.dart contains commonly used form validators. Typically, validators operate using
regular expressions to match the input value and return a response.
All validators MUST have a return type of String?.
 */

String? validateEmail(String? value) {
  String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value!)) {
    return 'Please enter a valid email address';
  } else {
    return null;
  }
}