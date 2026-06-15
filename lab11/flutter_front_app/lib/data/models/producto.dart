class Producto {
  final int id;
  final String nombre;
  final String? descripcion;
  final String categoria;
  final double precio;
  final int stock;
  final bool activo;

  Producto({
    required this.id,
    required this.nombre,
    this.descripcion,
    required this.categoria,
    required this.precio,
    required this.stock,
    required this.activo,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      categoria: json['categoria'],
      precio: (json['precio'] as num).toDouble(),
      stock: json['stock'],
      activo: json['activo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'descripcion': descripcion,
      'categoria': categoria,
      'precio': precio,
      'stock': stock,
      'activo': activo,
    };
  }
}
