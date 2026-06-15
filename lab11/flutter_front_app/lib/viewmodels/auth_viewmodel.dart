import 'package:flutter/material.dart';
import '../data/services/api_service.dart';

class AuthViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    notifyListeners();
    bool success = await _apiService.login(username, password);
    _isLoading = false;
    notifyListeners();
    return success;
  }
}
