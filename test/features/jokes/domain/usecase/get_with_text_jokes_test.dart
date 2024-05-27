import 'package:chucknorris_jokes/features/jokes/domain/entities/joke.dart';
import 'package:chucknorris_jokes/features/jokes/domain/repositories/joke_repository.dart';
import 'package:chucknorris_jokes/features/jokes/domain/usecases/get_joke_by_search.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_with_text_jokes_test.mocks.dart';

@GenerateNiceMocks([MockSpec<JokeRepository>()])
void main() {
  late MockJokeRepository mockJokesRepository;
  late GetJokeBySearch usecase;

  setUp(() {
    mockJokesRepository = MockJokeRepository();
    usecase = GetJokeBySearch(mockJokesRepository);
  });

  const testJoke =
      Joke(jokeText: 'test_text');

  test("Should get joke for the text from repository", () async {
    when(mockJokesRepository.getJokeBySearch(any))
        .thenAnswer((_) async => const Right(testJoke));

    final result = await usecase.call(const SearchParams(text: 'any'));

    expect(result, const Right(testJoke));
  });
}
