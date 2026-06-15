import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';
import 'product_list_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Column(
        children: [
          TextField(controller: _userController, decoration: InputDecoration(labelText: "Usuario")),
          TextField(controller: _passController, decoration: InputDecoration(labelText: "Password"), obscureText: true),
          ElevatedButton(
            onPressed: () async {
              final success = await Provider.of<AuthViewModel>(context, listen: false)
                  .login(_userController.text, _passController.text);
              if (success) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ProductListScreen()));
            },
            child: Text("Entrar"),
          )
        ],
      ),
    );
  }
}
