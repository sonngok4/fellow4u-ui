// presentation/viewmodels/guide_viewmodel.dart
import 'package:flutter/material.dart';

import '../../domain/entities/guide.dart';
import '../../domain/repositories/guide_repository.dart';

class GuideViewModel extends ChangeNotifier {
  final GuideRepository _repository;
  Guide? _currentGuide;
  bool _isLoading = false;
  String? _error;

  GuideViewModel(this._repository);

  Guide? get currentGuide => _currentGuide;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> registerGuide({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String address,
    required String city,
    required String country,
    required String guideLicenseUrl,
    required String identityCardUrl,
    required List<String> languages,
    required String introduction,
    String? videoIntroductionUrl,
    required Map<String, double> fees,
    required Map<String, List<TimeSlot>> availability,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final guide = Guide(
        id: DateTime.now()
            .millisecondsSinceEpoch
            .toString(), // Temporary ID generation
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        address: address,
        city: city,
        country: country,
        guideLicenseUrl: guideLicenseUrl,
        identityCardUrl: identityCardUrl,
        languages: languages,
        introduction: introduction,
        videoIntroductionUrl: videoIntroductionUrl,
        fees: fees,
        availability: availability,
      );

      await _repository.registerGuide(guide);
      _currentGuide = guide;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
