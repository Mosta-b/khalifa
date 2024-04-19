class HandleQadiayaValidation {
  String? validateNumber(String value) {
    if (value.isEmpty) {
      return 'Please enter a number';
    }
    final number = int.tryParse(value);
    if (number == null || number < 1 || number > 50) {
      return 'Please enter a number between 1 and 50';
    }
    return null;
  }

  String? validateArabicText(String value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    if (!isArabic(value)) {
      return 'Please enter Arabic text';
    }
    if (value.length > 50) {
      return 'Text should not exceed 50 letters';
    }
    return null;
  }

  bool isArabic(String value) {
    // Regular expression to match Arabic letters
    final arabicRegex = RegExp(r'^[\u0600-\u06FF\s]+$');
    return arabicRegex.hasMatch(value);
  }
}
