import 'package:local_auth/local_auth.dart';

abstract class AuthenticationBiometricsDataSource {
  Future<bool> requestBiometricsAuth();
}

class AuthenticationBiometricsDataSourceImplementation
    implements AuthenticationBiometricsDataSource {
  @override
  Future<bool> requestBiometricsAuth() async {
    final LocalAuthentication auth = LocalAuthentication();
    final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to continue',
        options: const AuthenticationOptions(biometricOnly: true));
    return didAuthenticate;
  }
}
