class LoginEntity {
  final bool success;
  final String? message;
  final String? token;

  LoginEntity({
    required this.success,
    required this.message,
    required this.token,
  });
}
