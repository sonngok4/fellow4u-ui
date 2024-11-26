import '../../domain/entities/guide.dart';

class GuideModel extends Guide {
  GuideModel({
    required super.id,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? address,
    String? city,
    String? country,
    String? guideLicenseUrl,
    String? identityCardUrl,
    required super.languages,
    required super.introduction,
    super.videoIntroductionUrl,
    required super.fees,
    required super.availability,
  }) : super(
          firstName: firstName ?? '',
          lastName: lastName ?? '',
          email: email ?? '',
          phoneNumber: phoneNumber ?? '',
          address: address ?? '',
          city: city ?? '',
          country: country ?? '',
          guideLicenseUrl: guideLicenseUrl ?? '',
          identityCardUrl: identityCardUrl ?? '',
        );

  // Convert from JSON to Model
  factory GuideModel.fromGuideJson(Map<String, dynamic> json) {
    // print('Parsing Guide JSON: $json');
    return GuideModel(
      id: json['id']?.toString() ?? '', // Explicitly convert to string
      firstName: json['first_name']?.toString() ?? '', // Add this if applicable
      lastName: json['last_name']?.toString() ?? '', // Add this if applicable
      email: json['email']?.toString() ?? '', // Add this if applicable
      phoneNumber:
          json['phone_number']?.toString() ?? '', // Add this if applicable
      address: json['address']?.toString() ?? '', // Add this if applicable
      city: json['city']?.toString() ?? '', // Add this if applicable
      country: json['country']?.toString() ?? '', // Add this if applicable
      guideLicenseUrl:
          json['guide_license_url']?.toString() ?? '', // Add appropriate field
      identityCardUrl:
          json['identity_card_url']?.toString() ?? '', // Add appropriate field
      languages: List<String>.from(json['languages'] ?? []),
      introduction: json['description']?.toString() ?? '',
      videoIntroductionUrl:
          json['video_introduction_url']?.toString(), // Optional
      fees: {
        '1': (json['price_per_day'] is num)
            ? json['price_per_day']?.toDouble() ?? 0.0
            : double.tryParse(json['price_per_day']?.toString() ?? '0') ?? 0.0
      },
      availability: {}, // You might need to parse this from the JSON if available
    );
  }

  // Convert from Entity to Model
  factory GuideModel.fromEntity(Guide guide) {
    return GuideModel(
      id: guide.id,
      firstName: guide.firstName,
      lastName: guide.lastName,
      email: guide.email,
      phoneNumber: guide.phoneNumber,
      address: guide.address,
      city: guide.city,
      country: guide.country,
      guideLicenseUrl: guide.guideLicenseUrl,
      identityCardUrl: guide.identityCardUrl,
      languages: guide.languages,
      introduction: guide.introduction,
      videoIntroductionUrl: guide.videoIntroductionUrl,
      fees: guide.fees,
      availability: guide.availability,
    );
  }

  // Convert from Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'city': city,
      'country': country,
      'guideLicenseUrl': guideLicenseUrl,
      'identityCardUrl': identityCardUrl,
      'languages': languages,
      'introduction': introduction,
      'videoIntroductionUrl': videoIntroductionUrl,
      'fees': fees,
      'availability': availability.map((day, slots) => MapEntry(day,
          slots.map((slot) => {'from': slot.from, 'to': slot.to}).toList())),
    };
  }

  // Convert from Model to Entity
  Guide toEntity() {
    return Guide(
      id: id,
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
  }
}
