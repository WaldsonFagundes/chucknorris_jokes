// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import '../../../../core/core_e.dart';
import '../models/models_e.dart';

abstract class JokeLocalDataSource {
  Future<JokeModel> getLastJoke();

  Future<void> cacheJoke(JokeModel jokeCache);
}

const String cachedJokeKey = "CACHED_JOKE";

class JokeLocalDataSourceImpl implements JokeLocalDataSource {
  final SharedPreferences sharedPreferences;

  JokeLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheJoke(JokeModel jokeCache) async {
    sharedPreferences.setString(cachedJokeKey, json.encode(jokeCache));
  }

  @override
  Future<JokeModel> getLastJoke() {
    final jsonString = sharedPreferences.getString(cachedJokeKey);
    if (jsonString != null) {
      final jsonMap = json.decode(jsonString);
      return Future.value(JokeModel.fromJson(jsonMap));
    } else {
      throw CacheException();
    }
  }
}
