class Failure {
  int? statusCode;
  String message;
  Failure({
    this.statusCode = 500,
    required this.message,
  });

  @override
  String toString() => 'Failure(statusCode: $statusCode, message: $message)';
}
