import '../../../../core/enums/user_type.dart';

class User {
  final String id;
  final String email;
  final String fullName;
  final String phoneNumber;
  final String avatar;
  final UserType userType;
  final String status;
  final String preferredLanguage;
  final String createdAt;
  final String updatedAt;

  User(
      {required this.id,
      required this.email,
      required this.fullName,
      required this.phoneNumber,
      required this.avatar,
      required this.userType,
      required this.status,
      required this.preferredLanguage,
      required this.createdAt,
      required this.updatedAt});
}
