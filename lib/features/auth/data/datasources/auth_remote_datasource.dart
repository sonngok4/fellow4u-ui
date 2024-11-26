// auth_remote_datasource.dart
import '../../../../core/enums/user_type.dart';
import '../../domain/entities/user.dart';

abstract class AuthRemoteDataSource {
  Future<User> login({
    required String email,
    required String password,
    required UserType userType,
  });

  Future<User> register({
    required String email,
    required String password,
    required String name,
    required UserType userType,
    String? phoneNumber,
  });

  Future<void> logout();

  Future<bool> verifyToken(String token);
}

// auth_local_datasource.dart
abstract class AuthLocalDataSource {
  Future<User?> getLastUser();
  Future<void> cacheUser(User user);
  Future<void> clearUser();
}
