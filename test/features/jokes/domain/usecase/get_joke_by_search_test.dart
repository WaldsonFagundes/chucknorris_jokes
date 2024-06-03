// Package imports:
import 'package:chucknorris_jokes/core/core_e.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:chucknorris_jokes/features/jokes/domain/entities/joke.dart';
import 'package:chucknorris_jokes/features/jokes/domain/repositories/joke_repository.dart';
import 'package:chucknorris_jokes/features/jokes/domain/usecases/get_joke_by_search.dart';

import 'get_joke_by_search_test.mocks.dart';

@GenerateNiceMocks([MockSpec<JokeRepository>()])
void main() {
  late MockJokeRepository mockJokeRepository;
  late GetJokeBySearch usecase;

  setUp(() {
    mockJokeRepository = MockJokeRepository();
    usecase = GetJokeBySearch(mockJokeRepository);
  });

  const testJoke = Joke(jokeText: 'test text');
  const testParams = SearchParams(text: 'any');

  test("Should get joke for the text from repository", () async {
    when(mockJokeRepository.getJokeBySearch(any))
        .thenAnswer((_) async => const Right(testJoke));

    final result = await usecase(testParams);

    expect(result, const Right(testJoke));
    verify(mockJokeRepository.getJokeBySearch(testParams.text));
    verifyNoMoreInteractions(mockJokeRepository);
  });

  test("Should return server failure when repository call is unsuccessful",
      () async {
    when(mockJokeRepository.getJokeBySearch(any))
        .thenAnswer((_) async => Left(ServerFailure()));

    final result = await usecase(testParams);
    
    expect(result, Left(ServerFailure()));
    verify(mockJokeRepository.getJokeBySearch(testParams.text));
    verifyNoMoreInteractions(mockJokeRepository);
  });

  test("Should return cache failure when repository call is unsuccessful",
          () async {
        when(mockJokeRepository.getJokeBySearch(any))
            .thenAnswer((_) async => Left(CacheFailure()));

        final result = await usecase(testParams);

        expect(result, Left(CacheFailure()));
        verify(mockJokeRepository.getJokeBySearch(testParams.text));
        verifyNoMoreInteractions(mockJokeRepository);
      });
}
