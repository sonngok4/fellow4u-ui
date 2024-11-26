// lib/features/trips/presentation/providers/trips_provider.dart

import 'package:dartz/dartz.dart';
import 'package:fellow4u_ui/core/errors/failures.dart';
import 'package:fellow4u_ui/features/trips/domain/entities/trip.dart';
import 'package:flutter/material.dart';
import '../../../domain/repositories/trip_repository.dart';

class TripsProvider extends ChangeNotifier {
  final TripRepository _repository;

  TripsProvider({required TripRepository repository})
      : _repository = repository;

  List<Trip> _trips = [];
  bool _isLoading = false;
  String? _error;

  List<Trip> get trips => _trips;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchTrips() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _trips = (await _repository.getTrips());
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Either<Failure, Trip>?> getTripById(String id) async {
    try {
      return await _repository.getTripById(id);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return null;
    }
  }
}
