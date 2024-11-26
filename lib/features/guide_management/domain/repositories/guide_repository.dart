// domain/repositories/guide_repository.dart
import '../entities/guide.dart';

abstract class GuideRepository {
  Future<void> addGuide(Guide guide);
  Future<void> registerGuide(Guide guide);
  Future<Guide?> getGuideProfile(String id);
  Future<void> updateGuideProfile(Guide guide);
  Future<void> updateGuideFees(String guideId, Map<String, double> fees);
  Future<void> updateGuideAvailability(
      String guideId, Map<String, List<TimeSlot>> availability);
  Future<List<Guide>> searchGuides({
    String? city,
    String? language,
    DateTime? date,
    int? numberOfTravelers,
  });
  Future<void> removeGuide(String id);
  Future<List<Guide>> getGuides();
  Future<List<Guide>> getAllGuides();
  Future<Guide?> getGuide(String id);
  Future<void> updateGuide(Guide guide);
}
