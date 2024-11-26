

// Register usecase
import 'package:dartz/dartz.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/errors/failures.dart';

import '../../../../core/enums/user_type.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

// Params cho Register usecase
class RegisterParams {
  final String email;
  final String password;
  final String name;
  final UserType userType;
  final String? phoneNumber;

  RegisterParams({
    required this.email,
    required this.password,
    required this.name,
    required this.userType,
    this.phoneNumber,
  });
}

class Register implements UseCase<User, RegisterParams> {
  final AuthRepository repository;

  Register(this.repository);

  @override
  Future<Either<Failure, User>> call(RegisterParams params) async {
    // Validate email
    if (!_isValidEmail(params.email)) {
      return Left(ValidationFailure('Invalid email format'));
    }

    // Validate password
    if (!_isValidPassword(params.password)) {
      return Left(ValidationFailure('Password must be at least 6 characters'));
    }

    // Validate name
    if (!_isValidName(params.name)) {
      return Left(ValidationFailure('Name must not be empty'));
    }

    // Validate phone number if provided
    if (params.phoneNumber != null &&
        !_isValidPhoneNumber(params.phoneNumber!)) {
      return Left(ValidationFailure('Invalid phone number format'));
    }

    return await repository.register(
      email: params.email,
      password: params.password,
      name: params.name,
      userType: params.userType,
      phoneNumber: params.phoneNumber,
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(email);
  }

  bool _isValidPassword(String password) {
    return password.length >= 6;
  }

  bool _isValidName(String name) {
    return name.trim().isNotEmpty;
  }

  bool _isValidPhoneNumber(String phoneNumber) {
    return RegExp(r'^\+?[\d\s-]+$').hasMatch(phoneNumber);
  }
}
