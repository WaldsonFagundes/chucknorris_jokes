abstract class JokesEvent {
  const JokesEvent();
}

class GetJokeForCategory extends JokesEvent {
  final String category;

  const GetJokeForCategory(this.category);
}

class GetJokeForSearch extends JokesEvent {
  final String textSearch;

  const GetJokeForSearch(this.textSearch);
}

class GetJokeForRandom extends JokesEvent {}

class GetCategoriesEvent extends JokesEvent {}
