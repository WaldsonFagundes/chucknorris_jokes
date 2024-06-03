import 'package:chucknorris_jokes/features/jokes/domain/entities/joke.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const testJokeText = 'Test text';
  const joke = Joke(jokeText: testJokeText);

  test("Should be initialized correctly", () {
    expect(joke.jokeText, testJokeText);
  });

  test('should support value equality', () {
    // Keeping the 'final' keyword to ensure the integrity of the test
    // ignore: prefer_const_constructors
    final joke1 = Joke(jokeText: testJokeText);
    // ignore: prefer_const_constructors
    final joke2 = Joke(jokeText: testJokeText);

    expect(joke1, equals(joke2));
    expect(joke1, joke2);
  });
}
