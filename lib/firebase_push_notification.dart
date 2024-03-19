import 'package:firebase_messaging/firebase_messaging.dart';

class FireBaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    try {
      await _requestNotificationPermissions();
      final fcmToken = await _firebaseMessaging.getToken();
      print('FCM Token: $fcmToken');
      _initializePushNotifications();
    } catch (e) {
      print('Error initializing notifications: $e');
    }
  }

  Future<void> _requestNotificationPermissions() async {
    NotificationSettings settings =
        await _firebaseMessaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission for notifications');
    } else {
      print('User denied permission for notifications');
      // Handle case where user denies permission (e.g., show explanation dialog)
    }
  }

  void _initializePushNotifications() {
    _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      sound: true,
      badge: true,
    );
    _firebaseMessaging.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    print('Received message in foreground:');
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Data: ${message.data}');

    // Add custom handling of the received message as needed
  }

  Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    print('Received message in background:');
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Data: ${message.data}');
    // Add custom handling of the received message in the background
  }
}
