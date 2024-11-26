import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../domain/entities/guide.dart';
import '../models/guide_model.dart';

abstract class GuideRemoteDatasource {
  Future<GuideModel> addGuide(GuideModel guide);
  Future<GuideModel> registerGuide(GuideModel guide);
  Future<GuideModel> getGuide(String guideId);
  Future<List<GuideModel>> getAllGuides();
  Future<void> updateGuideAvailability(
      String guideId, Map<String, List<TimeSlot>> availability);
  Future<void> updateGuideFees(String guideId, Map<String, double> fees);
  Future<void> updateGuideProfile(GuideModel guide);
  Future<GuideModel> getGuideProfile(String id);
  Future<List<GuideModel>> searchGuides({String? city, String? language});
  Future<void> removeGuide(String guideId);
  Future<GuideModel> updateGuide(GuideModel guide);
}

class GuideRemoteDatasourceImpl implements GuideRemoteDatasource {
  final http.Client client;
  final String baseUrl;

  GuideRemoteDatasourceImpl({required this.client, required this.baseUrl});

  @override
  Future<GuideModel> addGuide(GuideModel guide) async {
    final response = await client.post(
      Uri.parse('$baseUrl/guides'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(guide.toJson()),
    );

    if (response.statusCode == 201) {
      return GuideModel.fromGuideJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add guide: ${response.body}');
    }
  }

  @override
  Future<GuideModel> registerGuide(GuideModel guide) async {
    final response = await client.post(
      Uri.parse('$baseUrl/guides'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(guide.toJson()),
    );

    if (response.statusCode == 201) {
      return GuideModel.fromGuideJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add guide: ${response.body}');
    }
  }

  @override
  Future<GuideModel> getGuide(String guideId) async {
    final response = await client.get(
      Uri.parse('$baseUrl/guides/$guideId'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      return GuideModel.fromGuideJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get guide: ${response.body}');
    }
  }

@override
  Future<List<GuideModel>> getAllGuides() async {
    final response = await client.get(
      Uri.parse('$baseUrl/guides'),
      headers: {'Accept': 'application/json'},
    );

    // print("baseUrl: $baseUrl");
    // print("response.body: ${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseJson = json.decode(response.body);

      // Check if the response has a 'status' and 'data' key
      if (responseJson['status'] == 'success' && responseJson['data'] != null) {
        final List<dynamic> guideJsonList = responseJson['data']['guides'];
        return guideJsonList
            .map((guideJson) => GuideModel.fromGuideJson(guideJson))
            .toList();
      } else {
        throw Exception('Invalid response format');
      }
    } else {
      throw Exception('Failed to fetch guides: ${response.body}');
    }
  }

  @override
  Future<void> updateGuideAvailability(
      String guideId, Map<String, List<TimeSlot>> availability) async {
    final response = await client.put(
      Uri.parse('$baseUrl/guides/$guideId/availability'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(availability),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update guide availability: ${response.body}');
    }
  }

  @override
  Future<void> updateGuideFees(String guideId, Map<String, double> fees) async {
    final response = await client.put(
      Uri.parse('$baseUrl/guides/$guideId/fees'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(fees),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update guide fees: ${response.body}');
    }
  }

  @override
  Future<void> updateGuideProfile(GuideModel guide) async {
    final response = await client.put(
      Uri.parse('$baseUrl/guides/${guide.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(guide.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update guide profile: ${response.body}');
    }
  }

  @override
  Future<GuideModel> getGuideProfile(String id) async {
    final response = await client.get(
      Uri.parse('$baseUrl/guides/$id'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      return GuideModel.fromGuideJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get guide profile: ${response.body}');
    }
  }

  @override
  Future<List<GuideModel>> searchGuides(
      {String? city, String? language}) async {
    final response = await client.get(
      Uri.parse('$baseUrl/guides/search?city=$city&language=$language'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> guideJsonList = json.decode(response.body);
      return guideJsonList
          .map((guideJson) => GuideModel.fromGuideJson(guideJson))
          .toList();
    } else {
      throw Exception('Failed to search guides: ${response.body}');
    }
  }

  @override
  Future<void> removeGuide(String guideId) async {
    final response = await client.delete(
      Uri.parse('$baseUrl/guides/$guideId'),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to remove guide: ${response.body}');
    }
  }

  @override
  Future<GuideModel> updateGuide(GuideModel guide) async {
    final response = await client.put(
      Uri.parse('$baseUrl/guides/${guide.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(guide.toJson()),
    );

    if (response.statusCode == 200) {
      return GuideModel.fromGuideJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update guide: ${response.body}');
    }
  }
}
