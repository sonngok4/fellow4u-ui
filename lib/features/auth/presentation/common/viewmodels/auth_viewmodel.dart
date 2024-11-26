
import 'package:flutter/foundation.dart';
import '../../../../../core/enums/user_type.dart';
import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usescases/login.dart';
import '../../../domain/usescases/register.dart';

class AuthViewModel extends ChangeNotifier {
  final Login _login;
  final Register _register;

  AuthViewModel({
    required Login login,
    required Register register,
  })  : _login = login,
        _register = register;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  User? _currentUser;
  User? get currentUser => _currentUser;

  String? _error;
  String? get error => _error;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? error) {
    _error = error;
    notifyListeners();
  }

  Future<bool> login({
    required String email,
    required String password,
    required UserType userType,
  }) async {
    _setLoading(true);
    _setError(null);

    final result = await _login(
      LoginParams(
        email: email,
        password: password,
        userType: userType,
      ),
    );

    return result.fold(
      (failure) {
        _setError(_mapFailureToMessage(failure));
        _setLoading(false);
        return false;
      },
      (user) {
        _currentUser = user;
        _setLoading(false);
        return true;
      },
    );
  }

  Future<bool> register({
    required String email,
    required String password,
    required String name,
    required UserType userType,
    String? phoneNumber,
  }) async {
    _setLoading(true);
    _setError(null);

    final result = await _register(
      RegisterParams(
        email: email,
        password: password,
        name: name,
        userType: userType,
        phoneNumber: phoneNumber,
      ),
    );

    return result.fold(
      (failure) {
        _setError(_mapFailureToMessage(failure));
        _setLoading(false);
        return false;
      },
      (user) {
        _currentUser = user;
        _setLoading(false);
        return true;
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return 'Server Error. Please try again later.';
      case const (NetworkFailure):
        return 'No internet connection. Please check your connection and try again.';
      case const (InvalidCredentialsFailure):
        return 'Invalid email or password.';
      case const (EmailAlreadyInUseFailure):
        return 'This email is already registered.';
      default:
        return 'An unexpected error occurred.';
    }
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  void clearError() {
    _setError(null);
  }
}
