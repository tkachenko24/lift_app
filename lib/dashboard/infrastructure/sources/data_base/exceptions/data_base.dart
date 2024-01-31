class DataBaseExceptions implements Exception {
  final String name;
  final String description;

  const DataBaseExceptions({
    required this.name,
    required this.description,
  });
}
