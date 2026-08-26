import 'package:sinhala_dictionary_app/features/search/data/word_definition.dart';

sealed class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryEmpty extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<WordDefinition> englishHistory;
  final List<WordDefinition> sinhalaHistory;

  HistoryLoaded({required this.englishHistory, required this.sinhalaHistory});
}

class HistoryError extends HistoryState {
  final String message;

  HistoryError({required this.message});
}
