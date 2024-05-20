import 'package:chucknorris_jokes/features/jokes/domain/entities/jokes.dart';
import 'package:chucknorris_jokes/features/jokes/domain/repositories/jokes_repository.dart';
import 'package:chucknorris_jokes/features/jokes/domain/usecases/get_random_category_jokes.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'get_random_category_jokes_test.mocks.dart';

@GenerateNiceMocks([MockSpec<JokesRepository>()])


void main() {
  late MockJokesRepository mockJokesRepository;
  late GetRandomCategoryJokes usecase;

  setUp(() {
    mockJokesRepository = MockJokesRepository();
    usecase = GetRandomCategoryJokes(mockJokesRepository);
  });

  const testJokes = Jokes(jokeText: 'test_text');

  test("Should get joke for the category from repository", () async {
    when(mockJokesRepository.getRandomCategoryJokes(any))
        .thenAnswer((_) async => const Right(testJokes));

    final result = await usecase(const ParamsRandomCategory(category: 'any'));

    expect(result, const Right(testJokes));


  });
}
