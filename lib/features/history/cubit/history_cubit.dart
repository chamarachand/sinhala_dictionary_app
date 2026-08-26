import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sinhala_dictionary_app/core/enums/dictionary_language.dart';
import 'package:sinhala_dictionary_app/features/history/cubit/history_state.dart';
import 'package:sinhala_dictionary_app/features/history/repository/history_repository.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final HistoryRepository repository;
  HistoryCubit(this.repository) : super(HistoryInitial());

  Future<void> getHistory() async {
    final history = await Future.wait([
      repository.getHistory(DictionaryLanguage.english),
      repository.getHistory(DictionaryLanguage.sinhala),
    ]);

    emit(HistoryLoaded(englishHistory: history[0], sinhalaHistory: history[1]));
  }
}
