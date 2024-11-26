import 'package:flutter/foundation.dart';

import '../../domain/entities/guide.dart';
import '../../domain/repositories/guide_repository.dart';

class GuideProvider extends ChangeNotifier {
  final GuideRepository repository;

  GuideProvider({required this.repository});

  // State variables
  List<Guide> _guides = [];
  Guide? _currentGuide;
  bool _isLoading = false;
  String? _error;

  // Getters
  List<Guide> get guides => _guides;
  Guide? get currentGuide => _currentGuide;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Fetch all guides
  Future<void> fetchGuides() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _guides = await repository.getAllGuides();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  // Get a specific guide by ID
  Future<void> fetchGuide(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentGuide = await repository.getGuide(id);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  // Add a new guide
  Future<void> addGuide(Guide guide) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await repository.addGuide(guide);
      await fetchGuides(); // Refresh the list
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  // Update an existing guide
  Future<void> updateGuide(Guide guide) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await repository.updateGuide(guide);
      await fetchGuides(); // Refresh the list
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  // Remove a guide
  Future<void> removeGuide(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await repository.removeGuide(id);
      await fetchGuides(); // Refresh the list
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  // Search guides
  Future<void> searchGuides({
    String? city,
    String? language,
    DateTime? date,
    int? numberOfTravelers,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _guides = await repository.searchGuides(
        city: city,
        language: language,
        date: date,
        numberOfTravelers: numberOfTravelers,
      );
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  // Update guide availability
  Future<void> updateGuideAvailability(
    String guideId,
    Map<String, List<TimeSlot>> availability,
  ) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await repository.updateGuideAvailability(guideId, availability);
      await fetchGuide(guideId); // Refresh the current guide
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  // Update guide fees
  Future<void> updateGuideFees(
    String guideId,
    Map<String, double> fees,
  ) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await repository.updateGuideFees(guideId, fees);
      await fetchGuide(guideId); // Refresh the current guide
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }
}
