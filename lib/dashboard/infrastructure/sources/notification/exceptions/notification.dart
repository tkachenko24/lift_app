class NotificationExceptions implements Exception {
  final String name;
  final String description;

  const NotificationExceptions({
    required this.name,
    required this.description,
  });
}
