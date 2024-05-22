import 'package:chucknorris_jokes/core/network/network_info.dart';
import 'package:chucknorris_jokes/features/jokes/data/datasources/jokes_local_data_source.dart';
import 'package:chucknorris_jokes/features/jokes/data/datasources/jokes_remote_data_source.dart';
import 'package:chucknorris_jokes/features/jokes/data/repositories/jokes_repository_impl.dart';
import 'package:chucknorris_jokes/features/jokes/domain/repositories/jokes_repository.dart';
import 'package:chucknorris_jokes/features/jokes/domain/usecases/get_categories.dart';
import 'package:chucknorris_jokes/features/jokes/domain/usecases/get_random_category_jokes.dart';
import 'package:chucknorris_jokes/features/jokes/domain/usecases/get_random_jokes.dart';
import 'package:chucknorris_jokes/features/jokes/domain/usecases/get_with_text_jokes.dart';
import 'package:chucknorris_jokes/features/jokes/presentation/bloc/jokes_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => JokesBloc(
        getRandomCategoryJokes: sl(),
        getWithTextJokes: sl(),
        getRandomJokes: sl(),
        getCategories: sl(),
      ));

  sl.registerLazySingleton(() => GetCategories(sl()));
  sl.registerLazySingleton(() => GetRandomCategoryJokes(sl()));
  sl.registerLazySingleton(() => GetWithTextJokes(sl()));
  sl.registerLazySingleton(() => GetRandomJokes(sl()));

  sl.registerLazySingleton<JokesRepository>(() => JokesRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton<JokesRemoteDataSource>(() => JokesRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<JokesLocalDataSource>(() => JokesLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());





}
