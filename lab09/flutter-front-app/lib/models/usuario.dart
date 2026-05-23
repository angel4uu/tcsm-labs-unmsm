class Usuario {
  final String usuario;
  final String nombre;

  Usuario({required this.usuario, required this.nombre});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      usuario: json['usuario'] as String,
      nombre: json['nombre'] as String,
    );
  }
}
