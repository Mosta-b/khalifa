import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/user.dart';

class UserModel extends AuthUser {
  const UserModel({
    required super.email,
    required super.phoneNumber,
    required super.userName,
  });
  factory UserModel.fromFirebase(User user) => UserModel(
        userName: user.displayName ?? '',
        phoneNumber: user.phoneNumber ?? '',
        email: user.email ?? '',
      );
  factory UserModel.empty() => const UserModel(
        email: '',
        phoneNumber: '',
        userName: '',
      );
  factory UserModel.basicUser() => const UserModel(
        email: 'blida09r262015@gamil.com',
        phoneNumber: '+213123456789',
        userName: 'Mosta',
      );
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'phoneNumber': phoneNumber,
      'userName': userName,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      email: data['email'],
      phoneNumber: data['phoneNumber'],
      userName: data['userName'],
    );
  }
}
