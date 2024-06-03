// Package imports:
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'core/core_e.dart';
import 'features/jokes/jokes_e.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Blocs
  sl.registerFactory(() => JokeBloc(
        getJokeByCategory: sl(),
        getJokeBySearch: sl(),
        getRandomJoke: sl(),
      ));

  sl.registerFactory(() => CategoriesBloc(getCategories: sl()));

  // Use Cases
  sl.registerLazySingleton(() => GetCategories(sl()));
  sl.registerLazySingleton(() => GetJokeByCategory(sl()));
  sl.registerLazySingleton(() => GetJokeBySearch(sl()));
  sl.registerLazySingleton(() => GetRandomJoke(sl()));

  // Repositories
  sl.registerLazySingleton<CategoriesRepository>(() =>
      CategoriesRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<JokeRepository>(() => JokeRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));

// Data Source
  sl.registerLazySingleton<JokeRemoteDataSource>(
      () => JokeRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<JokeLocalDataSource>(
      () => JokeLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<CategoriesRemoteDataSource>(
      () => CategoriesRemoteDataSourceImpl(client: sl()));

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
