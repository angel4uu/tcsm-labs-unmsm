import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/usuario_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usuarioCtrl = TextEditingController();
  final contrasenaCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<UsuarioProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextField(controller: usuarioCtrl, decoration: const InputDecoration(labelText: 'Usuario')),
          TextField(controller: contrasenaCtrl, decoration: const InputDecoration(labelText: 'Contraseña'), obscureText: true),
          const SizedBox(height: 16),
          vm.isLoading ? const CircularProgressIndicator() : ElevatedButton(
            onPressed: () async {
              final ok = await vm.login(usuarioCtrl.text.trim(), contrasenaCtrl.text.trim());
              if (ok) {
                Navigator.pushReplacementNamed(context, '/search');
              } else {
                final msg = vm.error ?? 'Credenciales inválidas';
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
              }
            },
            child: const Text('Ingresar'),
          )
        ]),
      ),
    );
  }
}
