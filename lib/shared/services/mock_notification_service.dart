class NotificationModel {
  final int id;
  final String avatarUrl;
  final String name;
  final String message;
  final DateTime date;
  final NotificationType type;
  final bool isRead;
  final String? actionButtonText;

  NotificationModel({
    required this.id,
    required this.avatarUrl,
    required this.name,
    required this.message,
    required this.date,
    required this.type,
    this.isRead = false,
    this.actionButtonText,
  });
}

enum NotificationType { request, offer, tripCompleted }
class MockNotificationService {
  Future<List<NotificationModel>> getNotifications() async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    return [
      NotificationModel(
        id: 1,
        avatarUrl: 'https://i.pravatar.cc/',
        name: 'Tuan Tran',
        message:
            'accepted your request for the trip in Danang, Vietnam on Jan 20, 2020',
        date: DateTime(2020, 1, 16),
        type: NotificationType.request,
        isRead: true,
      ),
      NotificationModel(
        id: 2,
        avatarUrl: 'https://i.pravatar.cc/',
        name: 'Emmy',
        message:
            'sent you an offer for the trip in Ho Chi Minh, Vietnam on Feb 12, 2020',
        date: DateTime(2020, 1, 16),
        type: NotificationType.offer,
        isRead: false,
      ),
      NotificationModel(
        id: 3,
        avatarUrl: '', // No avatar for system notifications
        name: 'System',
        message:
            'Thanks! Your trip in Danang, Vietnam on Jan 20, 2020 has been finished. Please leave a review for the guide Tuan Tran.',
        date: DateTime(2020, 1, 24),
        type: NotificationType.tripCompleted,
        isRead: false,
        actionButtonText: 'Leave Review',
      ),
    ];
  }
}
