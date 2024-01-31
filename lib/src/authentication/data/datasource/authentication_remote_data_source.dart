import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:khalifa/core/constant/authorized/authorized_cred.dart';

import '../model/user_model.dart';

abstract class AuthnAuthenticationRemoteDataSourceContract {
  FirebaseAuth get auth;
  initialize() async {}
  getUser() async {}
  reload() async {}
  updateUserName({required String displayName}) async {}
  updateUserEmail({required String email}) async {}
  signOut() async {}
  signInWithGoogle() {}
  signInWithPhoneNumber({required String phoneNumber}) async {}
  verifyPhoneNumber({required String smsCode}) async {}
  sendPasswordRestCode({required String email}) async {}
  sendEmailVerification() {}

  createUser({
    required String email,
    required String password,
  }) async {}

  Future<bool> logIn({
    required String email,
    required String password,
  });
}

class AuthenticationRemoteDataSource
    implements AuthnAuthenticationRemoteDataSourceContract {
  String verificationIdForUser = '';
  @override
  FirebaseAuth get auth => FirebaseAuth.instance;
  // initialize
  @override
  initialize() async {
    await Firebase.initializeApp();
  }

  // getting the current user
  @override
  getUser() {
    if (auth.currentUser != null) {
      final UserModel user = UserModel.fromFirebase(auth.currentUser!);
      debugPrint(
          '${user.userName} ${user.phoneNumber} ${user.email} => get User in ${DateTime.now()}');
      return user;
    }
  }

  // reload the user
  @override
  reload() async {
    await auth.currentUser?.reload();
  }

  // create user with email and password
  @override
  createUser({
    required String email,
    required String password,
  }) async {
    await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // update user name call after signing into firebase
  @override
  updateUserName({required String displayName}) async {
    await auth.currentUser?.updateDisplayName(displayName);
    await auth.currentUser?.reload();
  }

  // update user email
  @override
  updateUserEmail({required String email}) async {
    // await auth.currentUser?.updateEmail(email);
    await auth.currentUser?.reload();
  }

  // log in
  @override
  logIn({
    required String email,
    required String password,
  }) async {
    if (email.toLowerCase() == authorizedEmail.toLowerCase() &&
        password.toLowerCase() == authorizedPassword.toLowerCase()) {
      return true;
    } else {
      return false;
    }
  }

  // sign out
  @override
  signOut() async {
    await auth.signOut();
  }

  // login or sign in with google
  @override
  signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication userAuthenticated =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: userAuthenticated.accessToken,
      idToken: userAuthenticated.idToken,
    );
    await auth.signInWithCredential(credential);
  }

  // sign in with phone number
  @override
  signInWithPhoneNumber({required String phoneNumber}) async {
    final Completer<String> verificationIdCompleter = Completer<String>();
    await auth.verifyPhoneNumber(
      timeout: const Duration(seconds: 60),
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) async {
        await auth.currentUser?.linkWithCredential(phoneAuthCredential);
      },
      verificationFailed: (FirebaseAuthException error) {
        verificationIdCompleter.completeError(error);
      },
      codeSent: (String verificationId, int? forceResendingToken) {
        verificationIdForUser = verificationId;
        verificationIdCompleter.complete(verificationId);
      },
      codeAutoRetrievalTimeout: (verificationId) {
        verificationIdForUser = verificationId;
        log('Your time has run out => signInWithPhoneNumber');
      },
    );

    return verificationIdCompleter.future;
  }

  // verify phone number
  @override
  verifyPhoneNumber({required String smsCode}) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationIdForUser,
      smsCode: smsCode,
    );
    await auth.currentUser?.linkWithCredential(credential);
  }

  // send password rest code
  @override
  sendPasswordRestCode({required String email}) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  // send email verification
  @override
  sendEmailVerification() async {
    await auth.currentUser?.sendEmailVerification();
  }
}
