import 'package:chucknorris_jokes/features/jokes/domain/entities/jokes.dart';
import 'package:chucknorris_jokes/features/jokes/domain/repositories/jokes_repository.dart';
import 'package:chucknorris_jokes/features/jokes/domain/usecases/get_random_jokes.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_random_jokes_test.mocks.dart';

@GenerateNiceMocks([MockSpec<JokesRepository>()])
void main() {
  late GetRandomJokes usecase;
  late MockJokesRepository mockJokesRepository;

  setUp(() {
    mockJokesRepository = MockJokesRepository();
    usecase = GetRandomJokes(mockJokesRepository);
  });

  const testJokes = Jokes(jokeText: 'test_text');

  test("Should get joke from the repository", () async {
   when(mockJokesRepository.getRandomJokes())
        .thenAnswer((_) async => const Right(testJokes));

    final result = await usecase(NoParamsRandom());

    expect(result, const Right(testJokes));
    verify(mockJokesRepository.getRandomJokes());
    verifyNoMoreInteractions(mockJokesRepository);

  });
}
