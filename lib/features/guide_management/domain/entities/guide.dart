// domain/entities/guide.dart
class Guide {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String address;
  final String city;
  final String country;
  final String guideLicenseUrl;
  final String identityCardUrl;
  final List<String> languages;
  final String introduction;
  final String? videoIntroductionUrl;
  final Map<String, double> fees; // Number of travelers -> fee per hour
  final Map<String, List<TimeSlot>> availability; // Day -> list of time slots

  Guide({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.city,
    required this.country,
    required this.guideLicenseUrl,
    required this.identityCardUrl,
    required this.languages,
    required this.introduction,
    this.videoIntroductionUrl,
    required this.fees,
    required this.availability,
  });
}

class TimeSlot {
  final String from;
  final String to;

  TimeSlot({required this.from, required this.to});
}
