abstract class NotificationSource {
  Future<void> send({
    required String title,
    required String description,
  });
}
