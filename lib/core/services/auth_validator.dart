class HandleValidation {
  isValidEmail(String? email) {
    // validating email
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');
    if (!emailRegex.hasMatch(email!)) {
      return 'Email invalide';
    } else {
      return null;
    }
  }

  validatePassword(String? password) {
    // Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, and one digit.
    final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,}$');

    if (password!.isEmpty) {
      return 'Mot de passe requis.';
    } else if (password.length < 8) {
      return 'Le mot de passe doit comporter au moins 8 caractères.';
    } else if (!passwordRegex.hasMatch(password)) {
      return 'Le mot de passe doit contenir au moins une lettre majuscule, \nune lettre minuscule et un chiffre.';
    }

    // Password is valid.
    return null;
  }

  isValidUsername(String? username) {
    // Regular expression to match only letters (both uppercase and lowercase)
    RegExp regex = RegExp(r'^[a-zA-Z]+$');

    if (!regex.hasMatch(username!)) {
      return "Nom d'utilisateur invalide";
    } else {
      return null;
    }
  }

  isPhoneNumberValid(String? phoneNumber) {
    // Check if the phone number is empty
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return "Le numéro de téléphone invalide";
    }
    phoneNumber = phoneNumber.trim();
    // regular expression pattern for phone numbers starting with 07, 06, or 05
    const pattern = r'^(07|06|05|01)\d{8}$';
    final regExp = RegExp(pattern);

    //the RegExp's hasMatch method to check if the phone number matches the pattern
    if (!regExp.hasMatch(phoneNumber.trim())) {
      return "Le numéro de téléphone n'est pas valide";
    }
  }

  bool validatePageNumber(String inputText, int maxPageLimit) {
    if (inputText.isEmpty) {
      // Text is empty
      return false;
    }

    // Check if inputText can be parsed as an integer
    try {
      int pageNumber = int.parse(inputText);
      if (pageNumber < 1 || pageNumber > maxPageLimit) {
        // Page number is out of range
        return false;
      }
      // Valid page number
      return true;
    } catch (e) {
      // Failed to parse as integer
      return false;
    }
  }
}
