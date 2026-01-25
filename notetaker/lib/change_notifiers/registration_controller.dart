import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notetaker/core/constants.dart';
import 'package:notetaker/core/dialogs.dart';
import 'package:notetaker/services/auth_service.dart';

class RegistrationController extends ChangeNotifier {
  bool _isRegisterMode = true;
  bool get isRegisterMode => _isRegisterMode;
  set isRegisterMode(bool value) {
    _isRegisterMode = value;
    notifyListeners();
  }

  bool _isPasswordHidden = true;
  bool get isPasswordHidden => _isPasswordHidden;
  set isPasswordHidden(bool value) {
    _isPasswordHidden = value;
    notifyListeners();
  }

  String _fullName = '';
  set fullName(String value) {
    _fullName = value;
    notifyListeners();
  }

  String get fullName => _fullName.trim();

  String _email = '';
  set email(String value) {
    _email = value;
    notifyListeners();
  }

  String get email => _email.trim();

  String _password = '';

  set password(String value) {
    _password = value;
    notifyListeners();
  }

  String get password => _password;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> authenticateWithEmailAndPassword({
    required BuildContext context,
  }) async {
    isLoading = true;
    try {
      //register the user
      if (_isRegisterMode) {
        await AuthService.register(
          fullName: fullName,
          email: email,
          password: password,
        );
        if (!context.mounted) return;
        showMessageDialog(
          context: context,
          message:
              'A verifiaction email sent to your email address. please verifyy the email.',
        );

        //reload the user
        while (!AuthService.isEmailVerified) {
          await Future.delayed(Duration(seconds: 5));
          AuthService.user?.reload();

          print(
            'Checking verification status : ${AuthService.isEmailVerified}',
          );
        }
      } else {
        //sign in the user

        await AuthService.login(email: email, password: password);
      }
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      //show the dialog
      showMessageDialog(
        context: context,
        message: authExceptionMapper[e.code] ?? 'An unknown error occured',
      );
    } catch (e) {
      if (!context.mounted) return;
      //show another dialog
      showMessageDialog(context: context, message: 'An unknown error occured');
    } finally {
      isLoading = false;
    }
  }

  Future<void> resetPassword({
    required BuildContext context,
    required String email,
  }) async {
    isLoading = true;
    try {
      await AuthService.resetPassword(email: email);
      if (!context.mounted) return;
      showMessageDialog(
        context: context,
        message:
            'A reset password link has been sent to $email. Open the link to reset your password ',
      );
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      //show the dialog
      showMessageDialog(
        context: context,
        message: authExceptionMapper[e.code] ?? 'An unknown error occured',
      );
    } catch (e) {
      if (!context.mounted) return;
      //show another dialog
      showMessageDialog(context: context, message: 'An unknown error occured');
    } finally {
      isLoading = false;
    }
  }
}
