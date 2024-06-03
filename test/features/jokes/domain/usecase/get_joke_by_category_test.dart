// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:chucknorris_jokes/core/core_e.dart';
import 'package:chucknorris_jokes/features/jokes/jokes_e.dart';
import 'get_joke_by_category_test.mocks.dart';

@GenerateNiceMocks([MockSpec<JokeRepository>()])
void main() {
  late MockJokeRepository mockJokeRepository;
  late GetJokeByCategory usecase;

  setUp(() {
    mockJokeRepository = MockJokeRepository();
    usecase = GetJokeByCategory(mockJokeRepository);
  });

  const testJokes = Joke(jokeText: 'test_text');
  const testParams = CategoryParams(category: 'any');

  test("Should get joke for the category from repository", () async {
    when(mockJokeRepository.getJokeByCategory(any))
        .thenAnswer((_) async => const Right(testJokes));

    final result = await usecase(testParams);

    expect(result, const Right(testJokes));
    verify(mockJokeRepository.getJokeByCategory(testParams.category));
    verifyNoMoreInteractions(mockJokeRepository);
  });

  test("Should return server failure when repository call is unsuccessful",
      () async {
    when(mockJokeRepository.getJokeByCategory(any))
        .thenAnswer((_) async => Left(ServerFailure()));

    final result = await usecase(testParams);

    expect(result, Left(ServerFailure()));
    verify(mockJokeRepository.getJokeByCategory(testParams.category));
    verifyNoMoreInteractions(mockJokeRepository);
  });


  test("Should return cache failure when repository call is unsuccessful",
          () async {
        when(mockJokeRepository.getJokeByCategory(any))
            .thenAnswer((_) async => Left(CacheFailure()));

        final result = await usecase(testParams);

        expect(result, Left(CacheFailure()));
        verify(mockJokeRepository.getJokeByCategory(testParams.category));
        verifyNoMoreInteractions(mockJokeRepository);
      });
}
