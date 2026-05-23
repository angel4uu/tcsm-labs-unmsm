import '../models/persona.dart';
import '../services/api_service.dart';
import 'persona_repository.dart';

class PersonaRepositoryImpl implements PersonaRepository {
  @override
  Future<List<Persona>> fetchPersonas([String? q]) async {
    final suffix = q == null || q.isEmpty ? '' : '?q=$q';
    final res = await ApiService.get('/personas$suffix');
    final data = res as List<dynamic>;
    return data.map((e) => Persona.fromJson(e as Map<String, dynamic>)).toList();
  }
}