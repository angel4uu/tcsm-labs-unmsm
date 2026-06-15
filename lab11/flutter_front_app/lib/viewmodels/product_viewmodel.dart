import 'package:flutter/material.dart';
import '../data/models/producto.dart';
import '../data/services/api_service.dart';

class ProductViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Producto> _productos = [];
  Producto? _selectedProducto;
  bool _isLoading = false;

  List<Producto> get productos => _productos;
  Producto? get selectedProducto => _selectedProducto;
  bool get isLoading => _isLoading;

  Future<void> fetchProductos() async {
    _isLoading = true;
    notifyListeners();
    _productos = await _apiService.listarProductos();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> buscarProductos(String query) async {
    _isLoading = true;
    notifyListeners();
    _productos = await _apiService.buscarProductos(query);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> obtenerProducto(int id) async {
    _isLoading = true;
    notifyListeners();
    _selectedProducto = await _apiService.obtenerProducto(id);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> crearProducto(Producto producto) async {
    _isLoading = true;
    notifyListeners();
    await _apiService.crearProducto(producto);
    await fetchProductos();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> actualizarProducto(Producto producto) async {
    _isLoading = true;
    notifyListeners();
    await _apiService.actualizarProducto(producto);
    await fetchProductos();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> eliminarProducto(int id) async {
    _isLoading = true;
    notifyListeners();
    await _apiService.eliminarProducto(id);
    await fetchProductos();
    _isLoading = false;
    notifyListeners();
  }
}
