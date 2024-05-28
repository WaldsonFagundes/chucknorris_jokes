// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:chucknorris_jokes/features/jokes/domain/entities/joke.dart';
import 'package:chucknorris_jokes/features/jokes/domain/repositories/joke_repository.dart';
import 'package:chucknorris_jokes/features/jokes/domain/usecases/get_joke_by_category.dart';
import 'get_random_category_jokes_test.mocks.dart';

@GenerateNiceMocks([MockSpec<JokeRepository>()])
void main() {
  late MockJokeRepository mockJokesRepository;
  late GetJokeByCategory usecase;

  setUp(() {
    mockJokesRepository = MockJokeRepository();
    usecase = GetJokeByCategory(mockJokesRepository);
  });

  const testJokes = Joke(jokeText: 'test_text');

  test("Should get joke for the category from repository", () async {
    when(mockJokesRepository.getJokeByCategory(any))
        .thenAnswer((_) async => const Right(testJokes));

    final result = await usecase(const CategoryParams(category: 'any'));

    expect(result, const Right(testJokes));
  });
}
