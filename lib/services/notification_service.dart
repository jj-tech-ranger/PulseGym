import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static Future<void> initialize(FlutterLocalNotificationsPlugin plugin) async {
    tz.initializeTimeZones();
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final ios = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    await plugin.initialize(InitializationSettings(android: android, iOS: ios));
  }

  static Future<void> showNotification(
    FlutterLocalNotificationsPlugin plugin, int id, String title, String body) async {
    const android = AndroidNotificationDetails(
      'pulsegym_channel', 'PulseGym Notifications',
      channelDescription: 'Workout reminders',
      importance: Importance.max, priority: Priority.high);
    await plugin.show(id, title, body, NotificationDetails(android: android));
  }
}
