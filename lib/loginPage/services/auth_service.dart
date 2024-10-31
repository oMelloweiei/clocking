class AuthService {
  // Simulating API delay
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    // Mock validation - in real app, this would be an API call
    if (email == 'test@example.com' && password == 'password123') {
      return true;
    }
    throw Exception('Invalid credentials');
  }
}
