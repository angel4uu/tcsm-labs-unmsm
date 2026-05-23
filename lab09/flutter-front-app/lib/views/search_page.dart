import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/persona_provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ctrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    final vm = Provider.of<PersonaProvider>(context, listen: false);
    vm.fetchPersonas();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PersonaProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Buscar Personas')),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            Expanded(child: TextField(controller: ctrl, decoration: const InputDecoration(labelText: 'Buscar'))),
            IconButton(onPressed: () => vm.fetchPersonas(ctrl.text.trim()), icon: const Icon(Icons.search))
          ]),
        ),
        if (vm.isLoading) const LinearProgressIndicator(),
        if (vm.error != null) Padding(padding: const EdgeInsets.all(8.0), child: Text(vm.error!)),
        Expanded(
          child: ListView.builder(
            itemCount: vm.personas.length,
            itemBuilder: (context, i) {
              final p = vm.personas[i];
              return ListTile(title: Text('${p.nombre} ${p.apellido}'), subtitle: Text('Código: ${p.codigo}'));
            },
          ),
        )
      ]),
    );
  }
}
