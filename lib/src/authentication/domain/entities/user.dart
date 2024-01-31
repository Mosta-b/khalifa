import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AuthUser extends Equatable {
  final String userName;
  final String phoneNumber;
  final String email;

  const AuthUser({
    required this.userName,
    required this.phoneNumber,
    required this.email,
  });

  @override
  List<Object?> get props => [phoneNumber, email];
}
