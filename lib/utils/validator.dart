class Validator {
  static String? required(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field is required';
    }
    return null;
  }

  static String? email(String? value) {
    required(value);
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? password(String? value) {
    required(value);
    if (value!.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }
}
