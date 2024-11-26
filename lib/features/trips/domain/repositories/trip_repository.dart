

  // lib/features/trips/domain/repositories/trip_repository.dart
  import 'package:dartz/dartz.dart';
  import '../../../../core/errors/failures.dart';
  import '../entities/trip.dart';

  abstract class TripRepository {
    Future<List<Trip>> getTrips();
    Future<Either<Failure, Trip>> getTripById(String id);
    Future<Either<Failure, List<Trip>>> getAvailableTrips();
  }
