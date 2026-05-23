import '../models/persona.dart';

abstract class PersonaRepository {
  Future<List<Persona>> fetchPersonas([String? q]);
}
