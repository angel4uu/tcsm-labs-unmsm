import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_front_app/main.dart';

class Registrar extends StatefulWidget {
  const Registrar({Key? key}) : super(key: key);

  @override
  State<Registrar> createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
  bool _loadingRegistrar = false;
  bool autoValidate = false;
  bool seguridad = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usuario = TextEditingController();
  final TextEditingController contra = TextEditingController();
  final TextEditingController contraValidar = TextEditingController();

  Future<void> _existe() async {
    var url = Uri.parse('http://10.0.2.2:5000/agregar_usuario');
    await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        "usuario": usuario.text,
        "contraseña": contra.text,
      }),
    );

    setState(() {
      _loadingRegistrar = false;
    });

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Message"),
        content: const Text("Registration completed successfully"),
        actions: [
          TextButton(
            onPressed: () {
              _Regresar();
            },
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  void _Regresar() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const Login()),
      (Route route) => false,
    );
  }

  void _validar() {
    if (_formKey.currentState!.validate() && contraValidar.text == contra.text) {
      _formKey.currentState!.save();
      if (!_loadingRegistrar) {
        setState(() {
          _loadingRegistrar = true;
        });
        _existe();
      }
    } else {
      if (contraValidar.text != contra.text) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Message"),
            content: const Text("Password fields do not match"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              )
            ],
          ),
        );
      } else {
        setState(() {
          autoValidate = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[700],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.cyan[700],
        leading: IconButton(
          onPressed: () {
            _Regresar();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 0, bottom: 80),
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.cyan[700]),
            child: Image.asset(
              'imagenes/logo3.png',
              color: Colors.white,
              height: 75,
            ),
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
                  autovalidateMode: autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _usuario(),
                        const SizedBox(height: 40),
                        _contra(),
                        const SizedBox(height: 40),
                        _contravalidar(),
                        const SizedBox(height: 40),
                        _btnRegistrar(),
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

  Widget _usuario() {
    return TextFormField(
      controller: usuario,
      decoration: const InputDecoration(labelText: "User"),
      validator: (valor) {
        if (valor == null || valor.isEmpty) {
          return 'Please enter values';
        }
        return null;
      },
    );
  }

  Widget _contra() {
    return TextFormField(
      controller: contra,
      obscureText: seguridad,
      decoration: const InputDecoration(labelText: "Password"),
      validator: (valor) {
        if (valor == null || valor.isEmpty) {
          return 'Please enter values';
        }
        return null;
      },
    );
  }

  Widget _contravalidar() {
    return TextFormField(
      controller: contraValidar,
      obscureText: seguridad,
      decoration: const InputDecoration(labelText: "Confirm Password"),
      validator: (valor) {
        if (valor == null || valor.isEmpty) {
          return 'Please enter values';
        }
        return null;
      },
    );
  }

  Widget _btnRegistrar() {
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
          const Text("Register", style: TextStyle(color: Colors.white)),
          if (_loadingRegistrar)
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
