import 'package:sinhala_dictionary_app/core/enums/dictionary_language.dart';
import 'package:sinhala_dictionary_app/core/services/database_service.dart';
import 'package:sinhala_dictionary_app/features/search/data/word_definition.dart';

class HistoryRepository {
  final DatabaseService dbService;
  HistoryRepository({required this.dbService});

  Future<List<WordDefinition>> getHistory(DictionaryLanguage language) async {
    final data = await dbService.getSearchHistory(language);

    return data.map((e) => WordDefinition.fromMap(e)).toList();
  }

  Future<void> saveToHistory(int wordId) async {
    await dbService.addToHistory(wordId);
  }
}
