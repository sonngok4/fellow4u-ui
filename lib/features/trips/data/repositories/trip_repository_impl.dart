// lib/features/trips/data/repositories/trip_repository_impl.dart
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/trip.dart';
import '../../domain/repositories/trip_repository.dart';
import '../datasources/trip_local_datasource.dart';
import '../datasources/trip_remote_datasource.dart';

class TripRepositoryImpl implements TripRepository {
  final TripRemoteDataSource remoteDataSource;
  final TripLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TripRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

@override
  Future<List<Trip>> getTrips() async {
    if (await networkInfo.isConnected) {
      final remoteTrips = await remoteDataSource.getTrips();

      // Convert TripModel to Trip using the factory method
      final trips =
          remoteTrips.map((tripModel) => Trip.fromModel(tripModel)).toList();

      await localDataSource.cacheTrips(remoteTrips);
      return trips;
    } else {
      final localTrips = await localDataSource.getLastTrips();

      // Convert local trips to Trip entities
      final trips =
          localTrips.map((tripModel) => Trip.fromModel(tripModel)).toList();
      return trips;
    }
  }

  @override
  Future<Either<Failure, Trip>> getTripById(String id) async {
    try {
      if (await networkInfo.isConnected) {
        final remoteTrip = await remoteDataSource.getTripById(id);
        await localDataSource.cacheTrip(remoteTrip);
        return Right(remoteTrip as Trip);
      } else {
        final localTrip = await localDataSource.getTrip(id);
        return Right(localTrip as Trip);
      }
    } on ServerException {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Trip>>> getAvailableTrips() {
    // TODO: implement getAvailableTrips
    throw UnimplementedError();
  }
}
