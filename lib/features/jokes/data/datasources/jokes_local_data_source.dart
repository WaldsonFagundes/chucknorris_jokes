import 'dart:convert';

import 'package:chucknorris_jokes/core/error/execeptions.dart';
import 'package:chucknorris_jokes/features/jokes/data/models/jokes_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class JokesLocalDataSource {
  Future<JokesModel> getLastJoke();

  Future<void> cacheJoke(JokesModel jokesCache);
}

const cachedJokes = "CACHED_JOKES";

class JokesLocalDataSourceImpl implements JokesLocalDataSource {
  final SharedPreferences sharedPreferences;

  JokesLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheJoke(JokesModel jokesCache) async {
    sharedPreferences.setString(cachedJokes, json.encode(jokesCache));
  }

  @override
  Future<JokesModel> getLastJoke() {
    final jsonString = sharedPreferences.getString(cachedJokes);
    if (jsonString != null) {
      return Future.value(JokesModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
