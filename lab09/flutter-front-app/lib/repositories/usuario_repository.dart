abstract class UsuarioRepository {
  Future<bool> authenticate(String usuario, String contrasena);
  Future<List<dynamic>> listUsuarios();
}
