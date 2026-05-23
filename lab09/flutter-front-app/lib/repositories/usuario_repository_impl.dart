import '../services/api_service.dart';
import 'usuario_repository.dart';

class UsuarioRepositoryImpl implements UsuarioRepository {
  @override
  Future<bool> authenticate(String usuario, String contrasena) async {
    final res = await ApiService.post('/usuarios', {
      'usuario': usuario,
      'contrasena': contrasena,
    });
    return res['success'] == true;
  }

  @override
  Future<List<dynamic>> listUsuarios() async {
    final res = await ApiService.get('/usuarios');
    return res as List<dynamic>;
  }
}