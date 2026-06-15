import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/product_viewmodel.dart';
import '../data/models/producto.dart';

class ProductFormScreen extends StatelessWidget {
  final Producto? producto;
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();

  ProductFormScreen({this.producto}) {
    if (producto != null) {
      _nombreController.text = producto!.nombre;
      _precioController.text = producto!.precio.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(producto == null ? "Crear Producto" : "Editar Producto")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _nombreController, decoration: InputDecoration(labelText: "Nombre")),
            TextField(controller: _precioController, decoration: InputDecoration(labelText: "Precio")),
            ElevatedButton(
              onPressed: () {
                final newProducto = Producto(
                  id: producto?.id ?? 0,
                  nombre: _nombreController.text,
                  categoria: "General",
                  precio: double.parse(_precioController.text),
                  stock: 10,
                  activo: true,
                );
                final vm = Provider.of<ProductViewModel>(context, listen: false);
                if (producto == null) vm.crearProducto(newProducto);
                else vm.actualizarProducto(newProducto);
                Navigator.pop(context);
              },
              child: Text("Guardar"),
            )
          ],
        ),
      ),
    );
  }
}
