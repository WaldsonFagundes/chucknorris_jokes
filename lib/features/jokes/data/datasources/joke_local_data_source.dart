import 'dart:convert';

import 'package:chucknorris_jokes/core/error/execeptions.dart';
import 'package:chucknorris_jokes/features/jokes/data/models/joke_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class JokeLocalDataSource {
  Future<JokeModel> getLastJoke();

  Future<void> cacheJoke(JokeModel jokesCache);
}

const cachedJoke = "CACHED_JOKE";

class JokeLocalDataSourceImpl implements JokeLocalDataSource {
  final SharedPreferences sharedPreferences;

  JokeLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheJoke(JokeModel jokesCache) async {
    sharedPreferences.setString(cachedJoke, json.encode(jokesCache));
  }

  @override
  Future<JokeModel> getLastJoke() {
    final jsonString = sharedPreferences.getString(cachedJoke);
    if (jsonString != null) {
      return Future.value(JokeModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
