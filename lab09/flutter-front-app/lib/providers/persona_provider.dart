import 'package:flutter/material.dart';
import '../models/persona.dart';
import '../repositories/persona_repository.dart';
import '../repositories/persona_repository_impl.dart';

class PersonaProvider extends ChangeNotifier {
  final PersonaRepository _repository = PersonaRepositoryImpl();

  bool isLoading = false;
  String? error;
  List<Persona> personas = [];

  Future<void> fetchPersonas([String? q]) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      personas = await _repository.fetchPersonas(q);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
