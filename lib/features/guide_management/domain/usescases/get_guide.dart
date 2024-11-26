import '../entities/guide.dart';
import '../repositories/guide_repository.dart';

class GetGuide {
  final GuideRepository repository;

  GetGuide(this.repository);

  // Method to get a single guide profile by ID
  Future<Guide?> call(String id) async => await repository.getGuideProfile(id);

  // Method to get all guides
  Future<List<Guide>> callAll() async => await repository.getGuides();

  // Method to get available guides (potentially with additional filtering)
  Future<List<Guide>> callAvailable() async => await repository.getAllGuides();
}
