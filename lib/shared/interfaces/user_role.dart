// lib/shared/interfaces/user_role.dart
import 'package:fellow4u_ui/core/enums/user_type.dart';

abstract class UserRole {
  UserType get userType;
  List<String> get permissions;
  bool canAccess(String feature);
}
