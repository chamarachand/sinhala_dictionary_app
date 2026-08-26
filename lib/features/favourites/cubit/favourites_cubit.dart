import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sinhala_dictionary_app/core/enums/dictionary_language.dart';
import 'package:sinhala_dictionary_app/features/favourites/cubit/favourites_state.dart';
import 'package:sinhala_dictionary_app/features/favourites/repositories/favourites_repository.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  final FavouritesRepository repository;
  FavouritesCubit(this.repository) : super(FavouritesInitial());

  Future<void> getFavourites() async {
    final favouriteWords = await Future.wait([
      repository.getFavourites(DictionaryLanguage.english),
      repository.getFavourites(DictionaryLanguage.sinhala),
    ]);

    emit(
      FavouritesLoaded(
        englishFavourites: favouriteWords[0],
        sinhalaFavourites: favouriteWords[1],
      ),
    );
  }
}
