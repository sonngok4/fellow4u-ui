import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../configs/app_config.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      // Auth
      'login': 'Login',
      'register': 'Register',
      'email': 'Email',
      'password': 'Password',
      'name': 'Name',
      'phone_number': 'Phone Number',
      'forgot_password': 'Forgot Password?',
      'dont_have_account': 'Don\'t have an account?',
      'already_have_account': 'Already have an account?',

      // User Types
      'traveler': 'Traveler',
      'guide': 'Guide',
      'agency': 'Agency',

      // Navigation
      'home': 'Home',
      'profile': 'Profile',
      'bookings': 'Bookings',
      'trips': 'Trips',
      'chat': 'Chat',

      // Forms
      'required_field': 'This field is required',
      'invalid_email': 'Please enter a valid email',
      'password_short': 'Password must be at least 6 characters',
      'submit': 'Submit',
      'cancel': 'Cancel',

      // Messages
      'success': 'Success',
      'error': 'Error',
      'loading': 'Loading...',
      'no_internet': 'No internet connection',
      'try_again': 'Try Again',

      // Profile
      'edit_profile': 'Edit Profile',
      'save_changes': 'Save Changes',
      'logout': 'Logout',

      // Reviews
      'write_review': 'Write a Review',
      'reviews': 'Reviews',
      'rating': 'Rating',

      // Payments
      'payment': 'Payment',
      'payment_methods': 'Payment Methods',
      'add_payment_method': 'Add Payment Method',

      // Search
      'search': 'Search',
      'search_placeholder': 'Search for trips, guides...',
      'filter': 'Filter',
      'sort': 'Sort',
    },
    'vi': {
      // Auth
      'login': 'Đăng nhập',
      'register': 'Đăng ký',
      'email': 'Email',
      'password': 'Mật khẩu',
      'name': 'Tên',
      'phone_number': 'Số điện thoại',
      'forgot_password': 'Quên mật khẩu?',
      'dont_have_account': 'Chưa có tài khoản?',
      'already_have_account': 'Đã có tài khoản?',

      // User Types
      'traveler': 'Người dùng',
      'guide': 'Hướng dẫn viên',
      'agency': 'Doanh nghiệp',

      // Navigation
      'home': 'Trang chủ',
      'profile': 'Trang cá nhân',
      'bookings': 'Đặt lịch',
      'trips': 'Chuyến đi',
      'chat': 'Tin nhắn',

      // Forms
      'required_field': 'Trường này là bắt buộc',
      'invalid_email': 'Vui lòng nhập email hợp lệ',
      'password_short': 'Mật khẩu phải có ít nhất 6 ký tự',
      'submit': 'Gửi',
      'cancel': 'Hủy',

      // Messages
      'success': 'Thành công',
      'error': 'Lỗi',
      'loading': 'Đang tải...',
      'no_internet': 'Không có kết nối mạng',
      'try_again': 'Thử lại',

      // Profile
      'edit_profile': 'Chỉnh sửa hồ sơ',
      'save_profile': 'Lưu thay đổi',
      'logout': 'Đăng xuất',

      // Reviews
      'write_review': 'Đánh giá',
      'reviews': 'Đánh giá',
      'rating': 'Đánh giá',

      // Payments
      'payment': 'Thanh toán',
      'payment_methods': 'Phương thức thanh toán',
      'add_payment_method': 'Thêm phương thức thanh toán',

      // Search
      'search': 'Tìm kiếm',
      'search_placeholder': 'Tìm kiếm chuyến đi, hướng dẫn...',
      'filter': 'Lọc',
      'sort': 'Sắp xếp',

    },
    // Add more languages as needed
  };

  String get login => _localizedValues[locale.languageCode]!['login']!;
  String get register => _localizedValues[locale.languageCode]!['register']!;
  String get email => _localizedValues[locale.languageCode]!['email']!;
  String get password => _localizedValues[locale.languageCode]!['password']!;
  String get name => _localizedValues[locale.languageCode]!['name']!;
  String get phoneNumber =>
      _localizedValues[locale.languageCode]!['phone_number']!;
  // Add getters for all other strings...

  // Helper method to get a string by key
  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppConfig.supportedLocales
        .map((e) => e.languageCode)
        .contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
