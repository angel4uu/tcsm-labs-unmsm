import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_front_app/Registrar.dart';
import 'package:flutter_front_app/Principal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'Inicio',
      routes: {
        'Inicio': (_) => const Login(),
      },
    );
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late String user;
  late String password;
  bool _loading = false;
  bool seguridad = true;
  bool _autoValidate = false;

  final TextEditingController usuario = TextEditingController();
  final TextEditingController contra = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _validar() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _loading = true;
      });
      _validarAcceso();
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

    Future<void> _validarAcceso() async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/Validar'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "usuario": usuario.text,
          "contraseña": contra.text,
        }),
      );

      if (!mounted) return;

      setState(() {
        _loading = false;
      });

      final data = json.decode(response.body);

      if (data.isEmpty) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Validation Error"),
            content: const Text("Incorrect user or password, please try again or register."),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("User Validated"),
            content: Text("Welcome ${data[0]["usuario"]} to the application"),
            actions: [
              TextButton(
                child: const Text("Accept"),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => Principal(usuario: usuario.text, contra: contra.text),
                    ),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Connection Error"),
          content: Text("Could not connect to the server: $e"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  void _PageRegistrar() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const Registrar();
        },
      ),
      (Route route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 8, bottom: 80),
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.cyan[700]),
            child: Image.asset('imagenes/logo2.png', color: Colors.white, height: 125),
          ),
          Center(
            child: Card(
              margin: const EdgeInsets.only(left: 40, right: 40, top: 0, bottom: 20),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                child: Form(
                  key: _formKey,
                  autovalidateMode: _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _usuariofield(),
                        const SizedBox(height: 40),
                        _contrasena(),
                        const SizedBox(height: 40),
                        _btningresar(),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Not registered?"),
                            TextButton(
                              onPressed: () {
                                _PageRegistrar();
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(color: Colors.cyan[700]),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _usuariofield() {
    return TextFormField(
      controller: usuario,
      decoration: const InputDecoration(labelText: "User"),
      validator: (valor) {
        if (valor == null || valor.isEmpty) {
          return "Please enter your username";
        }
        return null;
      },
      onSaved: (val) {
        user = val.toString();
      },
    );
  }

  Widget _contrasena() {
    return TextFormField(
      controller: contra,
      obscureText: seguridad,
      decoration: const InputDecoration(labelText: "Password"),
      validator: (valor) {
        if (valor == null || valor.isEmpty) {
          return "Please enter your password";
        }
        return null;
      },
      onSaved: (val) {
        password = val.toString();
      },
    );
  }

  Widget _btningresar() {
    return MaterialButton(
      height: 50,
      minWidth: 500,
      onPressed: () {
        _validar();
      },
      color: Colors.cyan[700],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Login', style: TextStyle(color: Colors.white)),
          if (_loading)
            Container(
              height: 20,
              width: 20,
              margin: const EdgeInsets.only(left: 20),
              child: const CircularProgressIndicator(color: Colors.white),
            )
        ],
      ),
    );
  }
}
