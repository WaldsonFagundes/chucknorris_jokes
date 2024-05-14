import 'package:chucknorris_jokes/features/jokes/data/models/jokes_model.dart';

abstract class JokesLocalDataSource {

  Future<JokesModel> getLastJoke();

  Future<void> cacheJoke (JokesModel jokesCache);

}