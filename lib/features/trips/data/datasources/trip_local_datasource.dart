// lib/features/trips/data/datasources/trip_local_data_source.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/trip_model.dart';

abstract class TripLocalDataSource {
  Future<List<TripModel>> getLastTrips();
  Future<TripModel> getTrip(String id);
  Future<void> cacheTrips(List<TripModel> tripsToCache);
  Future<void> cacheTrip(TripModel tripToCache);
}

class TripLocalDataSourceImpl implements TripLocalDataSource {
  final SharedPreferences sharedPreferences;
  final String cachedTripsKey = 'CACHED_TRIPS';

  TripLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<TripModel>> getLastTrips() async {
    final jsonString = sharedPreferences.getString(cachedTripsKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => TripModel.fromJson(json)).toList();
    } else {
      throw CacheException();
    }
  }

  @override
  Future<TripModel> getTrip(String id) async {
    final jsonString = sharedPreferences.getString('CACHED_TRIP_$id');
    if (jsonString != null) {
      return TripModel.fromJson(json.decode(jsonString));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheTrips(List<TripModel> tripsToCache) async {
    final List<Map<String, dynamic>> jsonList = tripsToCache
        .map<Map<String, dynamic>>((trip) => trip.toJson())
        .toList();
    await sharedPreferences.setString(
      cachedTripsKey,
      json.encode(jsonList),
    );
  }

  @override
  Future<void> cacheTrip(TripModel tripToCache) async {
    await sharedPreferences.setString(
      'CACHED_TRIP_${tripToCache.id}',
      json.encode(tripToCache.toJson()),
    );
  }
}