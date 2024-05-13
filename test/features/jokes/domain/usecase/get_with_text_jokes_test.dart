import 'package:chucknorris_jokes/features/jokes/domain/entities/jokes.dart';
import 'package:chucknorris_jokes/features/jokes/domain/repositories/jokes_repository.dart';
import 'package:chucknorris_jokes/features/jokes/domain/usecases/get_with_text_jokes.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_with_text_jokes_test.mocks.dart';

@GenerateNiceMocks([MockSpec<JokesRepository>()])
void main() {
  late MockJokesRepository mockJokesRepository;
  late GetWithTextJokes usecase;

  setUp(() {
    mockJokesRepository = MockJokesRepository();
    usecase = GetWithTextJokes(mockJokesRepository);
  });

  const testJoke =
      Jokes(jokeText: 'test_text');

  test("Should get joke for the text from repository", () async {
    when(mockJokesRepository.getWithTextJokes(any))
        .thenAnswer((_) async => const Right(testJoke));

    final result = await usecase.call(Params(text: 'any'));

    expect(result, const Right(testJoke));
  });
}
