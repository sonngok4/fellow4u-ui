// lib/features/trips/data/models/trip_model.dart
import '../../domain/entities/trip.dart';

class TripModel {
  final String id;
  final String title;
  final String description;
  final String itinerary;
  final String coverPhoto;
  final String location;
  final String startDate;
  final String endDate;
  final String departureDate;
  final String departurePlace;
  final String duration;
  final int maxParticipants;
  final String createdAt;
  final String guideId;

  // Pricing and Rating
  final double adultPrice;
  final double childPrice;
  final double rating;
  final int reviews;

  // Additional Trip Details
  final List<String> languages;
  final List<ScheduleModel> schedule;

  TripModel({
    required this.id,
    required this.title,
    required this.description,
    this.itinerary = '',
    required this.coverPhoto,
    required this.location,
    required this.startDate,
    required this.endDate,
    this.departureDate = '',
    this.departurePlace = '',
    required this.duration,
    required this.maxParticipants,
    required this.createdAt,
    required this.guideId,
    this.adultPrice = 0.0,
    this.childPrice = 0.0,
    this.rating = 0.0,
    this.reviews = 0,
    this.languages = const [],
    this.schedule = const [],
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: (json['id'] ?? 0).toString(),
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      coverPhoto: (json['images'] is List && json['images'].isNotEmpty)
          ? json['images'][0]?.toString() ?? ''
          : '',
      location: json['destination']?.toString() ?? '',

      // Handle dates
      startDate: DateTime.now()
          .toIso8601String(), // Or use a specific field if available
      endDate: DateTime.now()
          .add(Duration(days: json['duration_days'] ?? 0))
          .toIso8601String(),

      duration: (json['duration_days'] ?? 0).toString(),
      maxParticipants: json['max_participants'] ?? 0,
      createdAt:
          json['created_at']?.toString() ?? DateTime.now().toIso8601String(),
      guideId: (json['guide_id'] ?? 0).toString(),

      // Pricing
      adultPrice:
          double.tryParse(json['price_per_person']?.toString() ?? '0.0') ?? 0.0,

      // Additional fields with defaults
      itinerary: json['itinerary']?.toString() ?? '',
      departurePlace: json['meeting_point']?.toString() ?? '',
      departureDate: '', // Add appropriate mapping if available
      childPrice: 0.0,
      rating: 0.0,
      reviews: 0,
      languages: [],
      schedule: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'itinerary': itinerary,
      'coverPhoto': coverPhoto,
      'location': location,
      'startDate': startDate,
      'endDate': endDate,
      'departureDate': departureDate,
      'departurePlace': departurePlace,
      'duration': duration,
      'maxParticipants': maxParticipants.toString(),
      'createdAt': createdAt,
      'guideId': guideId,
      'adultPrice': adultPrice,
      'childPrice': childPrice,
      'rating': rating,
      'reviews': reviews,
      'languages': languages,
      'schedule': schedule.map((e) => e.toJson()).toList(),
    };
  }

  // Optional: Add equality and hashCode methods if needed
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TripModel &&
        id == other.id &&
        title == other.title &&
        description == other.description &&
        coverPhoto == other.coverPhoto &&
        location == other.location &&
        startDate == other.startDate &&
        endDate == other.endDate &&
        duration == other.duration &&
        maxParticipants == other.maxParticipants &&
        createdAt == other.createdAt &&
        guideId == other.guideId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        coverPhoto.hashCode ^
        location.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        duration.hashCode ^
        maxParticipants.hashCode ^
        createdAt.hashCode ^
        guideId.hashCode;
  }

  // Conversion method to convert TripModel to Trip entity
  Trip toEntity() => Trip(
        id: id,
        title: title,
        description: description,
        itinerary: itinerary,
        coverPhoto: coverPhoto,
        location: location,
        startDate: startDate,
        endDate: endDate,
        departureDate: departureDate,
        departurePlace: departurePlace,
        duration: duration,
        maxParticipants: maxParticipants,
        createdAt: createdAt,
        guideId: guideId,
        adultPrice: adultPrice,
        childPrice: childPrice,
        rating: rating,
        reviews: reviews,
        languages: languages,
        schedule: schedule,
      );

  // Conversion method to convert Trip entity to TripModel
  TripModel toModel() => TripModel(
        id: id,
        title: title,
        description: description,
        itinerary: itinerary,
        coverPhoto: coverPhoto,
        location: location,
        startDate: startDate,
        endDate: endDate,
        departureDate: departureDate,
        departurePlace: departurePlace,
        duration: duration,
        maxParticipants: maxParticipants,
        createdAt: createdAt,
        guideId: guideId,
        adultPrice: adultPrice,
        childPrice: childPrice,
        rating: rating,
        reviews: reviews,
        languages: languages,
        schedule: schedule,
      );
}


class ScheduleModel {
  final String time;
  final String description;

  ScheduleModel({
    required this.time,
    required this.description,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      time: json['time'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'description': description,
    };
  }
}
