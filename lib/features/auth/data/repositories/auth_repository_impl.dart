import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/enums/user_type.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
    required UserType userType,
  }) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }

    try {
      final remoteUser = await remoteDataSource.login(
        email: email,
        password: password,
        userType: userType,
      );

      await localDataSource.cacheUser(remoteUser);
      return Right(remoteUser);
    } on ServerException {
      return Left(ServerFailure());
    } on InvalidCredentialsException {
      return Left(InvalidCredentialsFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> register({
    required String email,
    required String password,
    required String name,
    required UserType userType,
    String? phoneNumber,
  }) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }

    try {
      final remoteUser = await remoteDataSource.register(
        email: email,
        password: password,
        name: name,
        userType: userType,
        phoneNumber: phoneNumber,
      );

      await localDataSource.cacheUser(remoteUser);
      return Right(remoteUser);
    } on ServerException {
      return Left(ServerFailure());
    } on EmailAlreadyInUseException {
      return Left(EmailAlreadyInUseFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await Future.wait([
        remoteDataSource.logout(),
        localDataSource.clearUser(),
      ]);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final cachedUser = await localDataSource.getLastUser();
      if (cachedUser != null) {
        // Verify token still valid with remote
        if (await remoteDataSource.verifyToken(cachedUser.id)) {
          return Right(cachedUser);
        }
      }
      await localDataSource.clearUser();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
