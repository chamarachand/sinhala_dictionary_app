import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sinhala_dictionary_app/core/services/api_service.dart';
import 'package:sinhala_dictionary_app/core/services/database_service.dart';
import 'package:sinhala_dictionary_app/core/services/local_storage_service.dart';
import 'package:sinhala_dictionary_app/features/ai_insights/cubit/ai_insights_cubit.dart';
import 'package:sinhala_dictionary_app/features/ai_insights/repository/ai_insights_repository.dart';
import 'package:sinhala_dictionary_app/features/favourites/cubit/favourites_cubit.dart';
import 'package:sinhala_dictionary_app/features/favourites/repositories/favourites_repository.dart';
import 'package:sinhala_dictionary_app/features/history/cubit/history_cubit.dart';
import 'package:sinhala_dictionary_app/features/history/repository/history_repository.dart';
import 'package:sinhala_dictionary_app/features/search/cubit/search_cubit.dart';
import 'package:sinhala_dictionary_app/features/search/repository/search_repository.dart';
import 'package:sinhala_dictionary_app/features/theme/cubit/theme_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  /// SharedPref
  final prefs = await SharedPreferences.getInstance();

  getIt.registerSingleton<SharedPreferences>(prefs);

  getIt.registerLazySingleton<LocalStorageService>(
    () => LocalStorageService(getIt<SharedPreferences>()),
  );

  /// Database
  final dbService = DatabaseService();
  await dbService.database;
  getIt.registerSingleton<DatabaseService>(dbService);

  /// API
  getIt.registerLazySingleton(() => ApiService());

  /// Repositories

  // WordRepository
  getIt.registerLazySingleton<WordRepository>(
    () => WordRepository(dbService: getIt<DatabaseService>()),
  );

  // FavouritesRepository
  getIt.registerLazySingleton<FavouritesRepository>(
    () => FavouritesRepository(dbService: getIt<DatabaseService>()),
  );

  // HistoryRepository
  getIt.registerLazySingleton<HistoryRepository>(
    () => HistoryRepository(dbService: getIt<DatabaseService>()),
  );

  // AiInsightsRepository
  getIt.registerLazySingleton<AiInsightsRepository>(
    () => AiInsightsRepository(
      apiService: getIt<ApiService>(),
      localStorageService: getIt<LocalStorageService>(),
    ),
  );

  // Cubits

  // ThemeCubit
  getIt.registerFactory<ThemeCubit>(
    () => ThemeCubit(localStorageService: getIt<LocalStorageService>()),
  );

  // SearchCubit
  getIt.registerFactory<SearchCubit>(
    () => SearchCubit(getIt<WordRepository>()),
  );

  // FavouritesCubit
  getIt.registerFactory<FavouritesCubit>(
    () => FavouritesCubit(getIt<FavouritesRepository>()),
  );

  // HistoryCubit
  getIt.registerFactory<HistoryCubit>(
    () => HistoryCubit(getIt<HistoryRepository>()),
  );

  // AiInsightsCubit
  getIt.registerFactory<AiInsightsCubit>(
    () => AiInsightsCubit(getIt<AiInsightsRepository>()),
  );
}
