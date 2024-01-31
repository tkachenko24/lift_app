import 'package:flutter/services.dart';
import 'package:notified_elevator/dashboard/export.dart';

class NotificationMethodChanelImplementation implements NotificationSource {
  final MethodChannel channel;

  const NotificationMethodChanelImplementation({required this.channel});

  @override
  Future<void> send({
    required String title,
    required String description,
  }) async {
    try {
      return channel.invokeMethod(
        'sendLocalNotification',
        {
          'title': "$title floor status updated!",
          'description': "Now we in $description floor",
        },
      );
    } catch (error) {
      throw NotificationExceptions(
          name: 'error', description: error.toString());
    }
  }
}
