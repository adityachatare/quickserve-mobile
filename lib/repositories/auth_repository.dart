import '../services/api_service.dart';

class AuthRepository {
  Future<bool> login(String email, String password) async {
    try {
      final result = await ApiService.login(email, password);
      return result;
    } catch (e) {
      throw Exception("Login failed");
    }
  }
}