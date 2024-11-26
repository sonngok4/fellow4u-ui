import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/guide_model.dart';

abstract class GuideLocalDatasource {
  Future<void> cacheGuide(GuideModel guide);
  Future<GuideModel?> getCachedGuide(String guideId);
  Future<List<GuideModel>> getCachedGuides();
  Future<void> removeCachedGuide(String guideId);
  Future<void> clearAllCachedGuides();
}

class GuideLocalDatasourceImpl implements GuideLocalDatasource {
  final SharedPreferences sharedPreferences;

  GuideLocalDatasourceImpl({required this.sharedPreferences});

  static const _guidesKey = 'cached_guides';

  @override
  Future<void> cacheGuide(GuideModel guide) async {
    final guides = await getCachedGuides();

    // Remove existing guide with same ID if exists
    guides.removeWhere((existingGuide) => existingGuide.id == guide.id);

    // Add new guide
    guides.add(guide);

    // Save updated list
    await _saveGuides(guides);
  }

  @override
  Future<GuideModel?> getCachedGuide(String guideId) async {
    final guides = await getCachedGuides();
    try {
      return guides.firstWhere((guide) => guide.id == guideId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<GuideModel>> getCachedGuides() async {
    final guidesJson = sharedPreferences.getStringList(_guidesKey) ?? [];
    return guidesJson
        .map((guideJson) => GuideModel.fromGuideJson(json.decode(guideJson)))
        .toList();
  }

  @override
  Future<void> removeCachedGuide(String guideId) async {
    final guides = await getCachedGuides();
    guides.removeWhere((guide) => guide.id == guideId);
    await _saveGuides(guides);
  }

  @override
  Future<void> clearAllCachedGuides() async {
    await sharedPreferences.remove(_guidesKey);
  }

  Future<void> _saveGuides(List<GuideModel> guides) async {
    final guidesJson =
        guides.map((guide) => json.encode(guide.toJson())).toList();

    await sharedPreferences.setStringList(_guidesKey, guidesJson);
  }
}
