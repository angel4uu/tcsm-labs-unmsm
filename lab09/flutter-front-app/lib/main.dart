import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/persona_provider.dart';
import 'providers/usuario_provider.dart';
import 'views/login_page.dart';
import 'views/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UsuarioProvider()),
        ChangeNotifierProvider(create: (_) => PersonaProvider()),
      ],
      child: MaterialApp(
        title: 'Lab09 Flutter',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginPage(),
          '/search': (context) => const SearchPage(),
        },
      ),
    );
  }
}
