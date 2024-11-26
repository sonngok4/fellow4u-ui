// lib/features/trips/domain/entities/trip.dart
import '../../data/models/trip_model.dart';

class Trip {
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

  const Trip({
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

  // Factory method to convert from TripModel
  factory Trip.fromModel(TripModel tripModel) {
    return Trip(
      id: tripModel.id,
      title: tripModel.title,
      description: tripModel.description,
      itinerary: tripModel.itinerary,
      coverPhoto: tripModel.coverPhoto,
      location: tripModel.location,
      startDate: tripModel.startDate,
      endDate: tripModel.endDate,
      departureDate: tripModel.departureDate,
      departurePlace: tripModel.departurePlace,
      duration: tripModel.duration,
      maxParticipants: tripModel.maxParticipants,
      createdAt: tripModel.createdAt,
      guideId: tripModel.guideId,
      adultPrice: tripModel.adultPrice,
      childPrice: tripModel.childPrice,
      rating: tripModel.rating,
      reviews: tripModel.reviews,
      languages: tripModel.languages,
      schedule: tripModel.schedule,
    );
  }

  // Utility methods
  bool get isUpcoming => DateTime.parse(startDate).isAfter(DateTime.now());

  String get formattedDuration {
    return duration.isNotEmpty ? '$duration days' : 'Duration not specified';
  }

  // Optional: Implement equality and hashCode
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Trip &&
          id == other.id &&
          title == other.title &&
          description == other.description;

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ description.hashCode;
}


