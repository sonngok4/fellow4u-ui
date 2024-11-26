// lib/features/trips/data/datasources/trip_remote_data_source.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/errors/exceptions.dart';
import '../models/trip_model.dart';

abstract class TripRemoteDataSource {
  Future<List<TripModel>> getTrips();
  Future<TripModel> getTripById(String id);
}

class TripRemoteDataSourceImpl implements TripRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  TripRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
  });

@override
  Future<List<TripModel>> getTrips() async {
    final response = await client.get(
      Uri.parse('$baseUrl/tours'),
      headers: {'Content-Type': 'application/json'},
    );
    print("baseUrl: $baseUrl");
    print("Trips Remote Data Source: ${response.body}");

    if (response.statusCode == 200) {
      try {
        final Map<String, dynamic> responseJson = json.decode(response.body);

        // Validate response structure
        if (responseJson['status'] == 'success' &&
            responseJson['data'] != null) {
          final dynamic toursData = responseJson['data']['tours'];

          // Ensure toursData is a List
          if (toursData is List) {
            return toursData
                .where((tripJson) => tripJson != null) // Filter out null items
                .map((tripJson) {
              // Ensure tripJson is a Map before parsing
              if (tripJson is Map<String, dynamic>) {
                return TripModel.fromJson(tripJson);
              }
              throw FormatException('Invalid trip data format');
            }).toList();
          } else {
            throw FormatException('Tours data is not a list');
          }
        } else {
          throw FormatException('Invalid response format');
        }
      } catch (e) {
        print('Error parsing trips: $e');
        throw Exception('Failed to parse trips: $e');
      }
    } else {
      throw Exception('Failed to fetch trips: ${response.body}');
    }
  }

  @override
  Future<TripModel> getTripById(String id) async {
    final response = await client.get(
      Uri.parse('$baseUrl/tours/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return TripModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
