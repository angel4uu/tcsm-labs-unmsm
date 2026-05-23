import 'package:flutter/material.dart';
import '../repositories/usuario_repository.dart';
import '../repositories/usuario_repository_impl.dart';

class UsuarioProvider extends ChangeNotifier {
  final UsuarioRepository _repository = UsuarioRepositoryImpl();

  bool isLoading = false;
  String? error;
  List<dynamic> usuarios = [];

  Future<bool> login(String usuario, String contrasena) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      final ok = await _repository.authenticate(usuario, contrasena);
      isLoading = false;
      notifyListeners();
      return ok;
    } catch (e) {
      error = e.toString();
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> listUsuarios() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      usuarios = await _repository.listUsuarios();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
