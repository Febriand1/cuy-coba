class Validator {
  static String? required(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field is required';
    }
    return null;
  }

  static String? email(String? value) {
    required(value);
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value!)) {
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

  static String? confirmPassword(String? value, String password) {
    required(value);
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? phone(String? value) {
    required(value);
    final cleaned = value!.replaceAll(RegExp(r'\s+'), '');

    final regex = RegExp(r'^(?:\+62|62|08)\d{8,12}$');
    if (!regex.hasMatch(cleaned)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }
}
