import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/product_viewmodel.dart';
import 'product_form_screen.dart';

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Productos"), actions: [
        IconButton(icon: Icon(Icons.add), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductFormScreen()))),
      ]),
      body: Column(
        children: [
          TextField(decoration: InputDecoration(hintText: "Buscar..."), onChanged: (v) => Provider.of<ProductViewModel>(context, listen: false).buscarProductos(v)),
          Expanded(child: Consumer<ProductViewModel>(
            builder: (context, vm, _) {
              if (vm.isLoading) return Center(child: CircularProgressIndicator());
              return ListView.builder(
                itemCount: vm.productos.length,
                itemBuilder: (context, i) {
                  final p = vm.productos[i];
                  return ListTile(
                    title: Text(p.nombre),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductFormScreen(producto: p))),
                    trailing: IconButton(icon: Icon(Icons.delete), onPressed: () => vm.eliminarProducto(p.id)),
                  );
                },
              );
            },
          ))
        ],
      ),
    );
  }
}
