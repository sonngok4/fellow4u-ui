import 'package:dartz/dartz.dart';

import 'package:fellow4u_ui/core/errors/failures.dart';

import '../entities/trip.dart';
import '../repositories/trip_repository.dart';

class GetTrip {
  final TripRepository tripRepository;

  GetTrip(this.tripRepository);

  // Method to get a single trip by ID
  Future<Either<Failure, Trip>> call(String id) async =>
      await tripRepository.getTripById(id);

  // Method to get all trips
  Future<List<Trip>> callAll() async =>
      await tripRepository.getTrips();

  // Method to get trips with specific filtering or conditions if needed
  Future<Either<Failure, List<Trip>>> callAvailable() async =>
      await tripRepository.getAvailableTrips();
}
