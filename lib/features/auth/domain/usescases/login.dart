import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/enums/user_type.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

// Params cho Login usecase
class LoginParams {
  final String email;
  final String password;
  final UserType userType;

  LoginParams({
    required this.email,
    required this.password,
    required this.userType,
  });
}

// Login usecase
class Login implements UseCase<User, LoginParams> {
  final AuthRepository repository;

  Login(this.repository);

  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    if (!_isValidEmail(params.email)) {
      return Left(ValidationFailure('Invalid email format'));
    }

    if (!_isValidPassword(params.password)) {
      return Left(ValidationFailure('Password must be at least 6 characters'));
    }

    return await repository.login(
      email: params.email,
      password: params.password,
      userType: params.userType,
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(email);
  }

  bool _isValidPassword(String password) {
    return password.length >= 6;
  }
}


