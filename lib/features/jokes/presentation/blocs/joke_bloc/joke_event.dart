abstract class JokeEvent {
  const JokeEvent();
}

class FetchJokeByCategory extends JokeEvent {
  final String category;

  const FetchJokeByCategory(this.category);
}

class FetchJokeBySearch extends JokeEvent {
  final String textSearch;

  const FetchJokeBySearch(this.textSearch);
}

class FetchRandomJoke extends JokeEvent {

}

