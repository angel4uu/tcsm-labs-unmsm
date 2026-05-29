import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_front_app/main.dart';

class Principal extends StatefulWidget {
  final String usuario;
  final String contra;

  const Principal({Key? key, required this.usuario, required this.contra}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  bool isLoading = false;
  late Timer _timer;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        isLoading = true;
      });
      t.cancel();
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[700],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.cyan[700],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              arrowColor: Colors.white,
              accountName: Text(widget.usuario),
              accountEmail: null,
              decoration: BoxDecoration(color: Colors.cyan[700]),
            ),
            ListTile(
              title: const Text("List"),
              onTap: () {},
            ),
            ListTile(
              title: const Text("Edit"),
              onTap: () {},
            ),
            ListTile(
              title: const Text("Delete"),
              onTap: () {},
            ),
            ListTile(
              title: const Text("Logout"),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const Login()),
                  (Route route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                "Welcome to iCardio, ${widget.usuario}!",
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
      ),
    );
  }
}
