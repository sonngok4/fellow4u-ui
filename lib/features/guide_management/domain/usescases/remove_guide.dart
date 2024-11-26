
import '../repositories/guide_repository.dart';

class RemoveGuide {
  final GuideRepository repository;

  RemoveGuide(this.repository);
  Future<void> call(String id) async => await repository.removeGuide(id);

}