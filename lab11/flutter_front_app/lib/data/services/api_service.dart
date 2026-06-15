import 'package:dio/dio.dart';
import '../models/producto.dart';
import '../network/dio_client.dart';
import '../network/token_storage.dart';

class ApiService {
  final Dio _dio = DioClient.dio;

  Future<bool> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {'username': username, 'password': password},
      );
      if (response.statusCode == 200) {
        TokenStorage().token = response.data['data']['access_token'];
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<List<Producto>> listarProductos() async {
    try {
      final response = await _dio.get('/productos');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((item) => Producto.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<List<Producto>> buscarProductos(String query) async {
    try {
      final response = await _dio.get('/productos/buscar', queryParameters: {'q': query});
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((item) => Producto.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<Producto?> obtenerProducto(int id) async {
    try {
      final response = await _dio.get('/productos/$id');
      if (response.statusCode == 200) {
        return Producto.fromJson(response.data['data']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> crearProducto(Producto producto) async {
    try {
      await _dio.post('/productos', data: producto.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> actualizarProducto(Producto producto) async {
    try {
      await _dio.put('/productos/${producto.id}', data: producto.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> eliminarProducto(int id) async {
    try {
      await _dio.delete('/productos/$id');
    } catch (e) {
      rethrow;
    }
  }
}
