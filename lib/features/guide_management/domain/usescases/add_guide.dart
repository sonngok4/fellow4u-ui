// domain/usecases/add_guide.dart
import '../entities/guide.dart';
import '../repositories/guide_repository.dart';

class AddGuide {
  final GuideRepository repository;

  AddGuide(this.repository);

  Future<void> call(Guide guide) async {
    await repository.registerGuide(guide);
  }
}
