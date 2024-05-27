import 'package:chucknorris_jokes/core/network/network_info.dart';
import 'package:chucknorris_jokes/features/jokes/data/datasources/categories_remote_data_source.dart';
import 'package:chucknorris_jokes/features/jokes/data/datasources/joke_local_data_source.dart';
import 'package:chucknorris_jokes/features/jokes/data/datasources/joke_remote_data_source.dart';
import 'package:chucknorris_jokes/features/jokes/data/repositories/categories_repository_impl.dart';
import 'package:chucknorris_jokes/features/jokes/data/repositories/joke_repository_impl.dart';
import 'package:chucknorris_jokes/features/jokes/domain/repositories/categories_repository.dart';
import 'package:chucknorris_jokes/features/jokes/domain/repositories/joke_repository.dart';
import 'package:chucknorris_jokes/features/jokes/domain/usecases/get_categories.dart';
import 'package:chucknorris_jokes/features/jokes/domain/usecases/get_joke_by_category.dart';
import 'package:chucknorris_jokes/features/jokes/domain/usecases/get_random_joke.dart';
import 'package:chucknorris_jokes/features/jokes/domain/usecases/get_joke_by_search.dart';
import 'package:chucknorris_jokes/features/jokes/presentation/blocs/categories_bloc/categories_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/jokes/presentation/blocs/joke_bloc/joke_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => JokeBloc(
        getJokeByCategory: sl(),
        getJokeBySearch: sl(),
        getRandomJoke: sl(),
      ));

  sl.registerLazySingleton<JokeRemoteDataSource>(
      () => JokeRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<JokeLocalDataSource>(
      () => JokeLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

  sl.registerFactory(() => CategoriesBloc(getCategories: sl()));

  sl.registerLazySingleton(() => GetCategories(sl()));
  sl.registerLazySingleton(() => GetJokeByCategory(sl()));
  sl.registerLazySingleton(() => GetJokeBySearch(sl()));
  sl.registerLazySingleton(() => GetRandomJoke(sl()));

  sl.registerLazySingleton<CategoriesRepository>(
      () => CategoriesRepositoryImpl(remoteDataSource: sl()));

  sl.registerLazySingleton<CategoriesRemoteDataSource>(
      () => CategoriesRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<JokeRepository>(() => JokeRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));
}
