import 'package:fellow4u_ui/core/configs/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/guide.dart';
import '../../domain/repositories/guide_repository.dart';
import '../datasources/guide_local_datasource.dart';
import '../datasources/guide_remote_datasource.dart';
import '../models/guide_model.dart';

class GuideRepositoryImpl implements GuideRepository {
  final GuideRemoteDatasource remoteDatasource;
  final GuideLocalDatasource localDatasource;
  
    // Constructor mặc định
  GuideRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  static Future<GuideRepositoryImpl> create() async {
    final client = http.Client();
    final baseUrl = AppConfig.apiBaseUrl;

    return GuideRepositoryImpl._(
      remoteDatasource:
          GuideRemoteDatasourceImpl(client: client, baseUrl: baseUrl),
      localDatasource: GuideLocalDatasourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
    );
  }

  GuideRepositoryImpl._({
    required this.remoteDatasource,
    required this.localDatasource,
  });
  

  @override
  Future<Guide> addGuide(Guide guide) async {
    try {
      // Convert domain entity to model
      final guideModel = GuideModel.fromEntity(guide);

      // Add to remote datasource
      final addedGuideModel = await remoteDatasource.addGuide(guideModel);

      // Cache locally
      await localDatasource.cacheGuide(addedGuideModel);

      return addedGuideModel.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Guide?> getGuide(String guideId) async {
    try {
      // Try to get from local cache first
      final cachedGuide = await localDatasource.getCachedGuide(guideId);
      if (cachedGuide != null) {
        return cachedGuide.toEntity();
      }

      // If not in cache, fetch from remote
      final guideModel = await remoteDatasource.getGuide(guideId);

      // Cache the fetched guide
      await localDatasource.cacheGuide(guideModel);

      return guideModel.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Guide>> getAllGuides() async {
    try {
      // Try to get from local cache first
      final cachedGuides = await localDatasource.getCachedGuides();
      if (cachedGuides.isNotEmpty) {
        return cachedGuides.map((model) => model.toEntity()).toList();
      }

      // If cache is empty, fetch from remote
      final guideModels = await remoteDatasource.getAllGuides();

      // Cache all fetched guides
      for (var guideModel in guideModels) {
        await localDatasource.cacheGuide(guideModel);
      }

      return guideModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeGuide(String guideId) async {
    try {
      // Remove from remote
      await remoteDatasource.removeGuide(guideId);

      // Remove from local cache
      await localDatasource.removeCachedGuide(guideId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Guide> updateGuide(Guide guide) async {
    try {
      // Convert domain entity to model
      final guideModel = GuideModel.fromEntity(guide);

      // Update in remote datasource
      final updatedGuideModel = await remoteDatasource.updateGuide(guideModel);

      // Update local cache
      await localDatasource.cacheGuide(updatedGuideModel);

      return updatedGuideModel.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Guide?> getGuideProfile(String id) async {
    try {
      final guideModel = await remoteDatasource.getGuideProfile(id);
      return guideModel.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Guide>> getGuides() async {
    try {
      final guideModels = await remoteDatasource.getAllGuides();
      return guideModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> registerGuide(Guide guide) async {
    try {
      final guideModel = GuideModel.fromEntity(guide);
      await remoteDatasource.registerGuide(guideModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Guide>> searchGuides({
    String? city,
    String? language,
    DateTime? date,
    int? numberOfTravelers,
  }) async {
    try {
      final guideModels = await remoteDatasource.searchGuides(
        city: city,
        language: language,
      );
      return guideModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateGuideAvailability(
      String guideId, Map<String, List<TimeSlot>> availability) async {
    try {
      await remoteDatasource.updateGuideAvailability(guideId, availability);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateGuideFees(String guideId, Map<String, double> fees) async {
    try {
      await remoteDatasource.updateGuideFees(guideId, fees);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateGuideProfile(Guide guide) async {
    try {
      final guideModel = GuideModel.fromEntity(guide);
      await remoteDatasource.updateGuideProfile(guideModel);
    } catch (e) {
      rethrow;
    }
  }
}
