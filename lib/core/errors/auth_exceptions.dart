// Signing Up with Email, Phone Number, and Username:

class InvalidEmailAuthException implements Exception {}

//     Invalid Email Format: You might encounter an exception if the user enters an email address in an incorrect format (e.g., missing "@" or domain).
class WeakPasswordAuthException implements Exception {}

//     Weak Password: If the user's chosen password does not meet your password strength requirements (e.g., too short), Firebase Authentication may raise an exception.
class EmailAlreadyInUseAuthException implements Exception {}

class PhoneNumberAlreadyInUseException implements Exception {}

class PhoneNumberInvalidAuthException implements Exception {}

//     Email Already Exists: When a user tries to sign up with an email address that is already associated with another account, you may encounter an exception indicating that the email is already in use.
class PhoneNumberVerificationFailedAuthException implements Exception {}

//     Phone Number Verification: If phone number verification fails (e.g., incorrect verification code), Firebase Authentication will raise an exception.
class UserNameTakenAuthException implements Exception {}

//     Username Uniqueness: If you require usernames to be unique and a user tries to sign up with a username that is already taken, you should handle this exception.

class InvalidSmsCodeAuthException implements Exception {}

// Signing Up with Google Account and Phone Number:

class GoogleSignInFailedAuthException implements Exception {}

// Logging In with Email and Password:

class InvalidCredentialsAuthException implements Exception {}

//     Invalid Credentials: If the user provides incorrect email and password combinations, Firebase Authentication will raise an exception indicating invalid credentials.
class UserDoesNotExistAuthException implements Exception {}

//     Account Does Not Exist: When a user attempts to log in with an email that is not registered or with a Google account that is not linked, you may encounter an exception indicating that the account does not exist.
class UserDisabledAuthException implements Exception {}

//     User Disabled: If you disable a user's account for some reason, Firebase Authentication may raise an exception when that user attempts to log in.

// Generic
class EmailAlreadyVerifiedAuthException implements Exception {}

class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}

class TooManyRequestAuthException implements Exception {}

class RequireRecentLogIn implements Exception {}
