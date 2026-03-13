class AuthSessionModel {
  final String accessToken;
  final String refreshToken;
  final String userName;
  final bool isAuthenticated;

  const AuthSessionModel({
    required this.accessToken,
    required this.refreshToken,
    required this.userName,
    required this.isAuthenticated,
  });
}
