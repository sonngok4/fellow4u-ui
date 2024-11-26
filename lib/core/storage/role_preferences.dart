// lib/core/storage/role_preferences.dart
import 'package:fellow4u_ui/core/enums/user_type.dart';

abstract class RolePreferences {
  Future<void> saveRoleSpecificSettings(
      UserType userType, Map<String, dynamic> settings);
  Future<Map<String, dynamic>> getRoleSpecificSettings(UserType userType);
}
