import 'package:flutter/material.dart';
import '../repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _setLoading(true);
    _setErrorMessage(null);
    try {
      await _authRepository.signInWithEmailAndPassword(email, password);
      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _setErrorMessage(e.message ?? 'An unknown error occurred');
      _setLoading(false);
      return false;
    } catch (e) {
      _setErrorMessage(e.toString());
      _setLoading(false);
      return false;
    }
  }

  Future<bool> signUp(String name, String email, String password) async {
    _setLoading(true);
    _setErrorMessage(null);
    try {
      User? user = await _authRepository.signUpWithEmailAndPassword(email, password);
      if (user != null && name.isNotEmpty) {
        await user.updateDisplayName(name);
      }
      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _setErrorMessage(e.message ?? 'An unknown error occurred');
      _setLoading(false);
      return false;
    } catch (e) {
      _setErrorMessage(e.toString());
      _setLoading(false);
      return false;
    }
  }

  Future<bool> resetPassword(String email) async {
    _setLoading(true);
    _setErrorMessage(null);
    try {
      await _authRepository.sendPasswordResetEmail(email);
      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _setErrorMessage(e.message ?? 'An unknown error occurred');
      _setLoading(false);
      return false;
    } catch (e) {
      _setErrorMessage(e.toString());
      _setLoading(false);
      return false;
    }
  }

  Future<void> logout() async {
    await _authRepository.signOut();
  }
}
