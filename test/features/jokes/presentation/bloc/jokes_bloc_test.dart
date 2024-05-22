import 'package:chucknorris_jokes/core/error/failures.dart';
import 'package:chucknorris_jokes/features/jokes/domain/entities/jokes.dart';
import 'package:chucknorris_jokes/features/jokes/domain/usecases/get_categories.dart';
import 'package:chucknorris_jokes/features/jokes/domain/usecases/get_random_category_jokes.dart';
import 'package:chucknorris_jokes/features/jokes/domain/usecases/get_random_jokes.dart';
import 'package:chucknorris_jokes/features/jokes/domain/usecases/get_with_text_jokes.dart';
import 'package:chucknorris_jokes/features/jokes/presentation/bloc/jokes_bloc.dart';
import 'package:chucknorris_jokes/features/jokes/presentation/bloc/jokes_event.dart';
import 'package:chucknorris_jokes/features/jokes/presentation/bloc/jokes_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'jokes_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<GetRandomCategoryJokes>()])
@GenerateNiceMocks([MockSpec<GetWithTextJokes>()])
@GenerateNiceMocks([MockSpec<GetRandomJokes>()])
@GenerateNiceMocks([MockSpec<GetCategories>()])
void main() {
  late MockGetRandomCategoryJokes mockGetRandomCategoryJokes;
  late MockGetWithTextJokes mockGetWithTextJokes;
  late MockGetRandomJokes mockGetRandomJokes;
  late MockGetCategories mockGetCategories;
  late JokesBloc bloc;

  setUp(() {
    mockGetRandomCategoryJokes = MockGetRandomCategoryJokes();
    mockGetWithTextJokes = MockGetWithTextJokes();
    mockGetRandomJokes = MockGetRandomJokes();
    mockGetCategories = MockGetCategories();

    bloc = JokesBloc(
      getRandomCategoryJokes: mockGetRandomCategoryJokes,
      getRandomJokes: mockGetRandomJokes,
      getWithTextJokes: mockGetWithTextJokes,
      getCategories: mockGetCategories,
    );
  });

  test("initialState should be Empty ", () {
    expect(bloc.state, equals(Empty()));
  });

  group('GetRandomCategoryJokes', () {
    const testTextCategory = 'any category';

    const testJokes = Jokes(jokeText: 'Test joke');

    test("Should get data from the GetRandomCategoryJokes use case", () async {
      when(mockGetRandomCategoryJokes(any))
          .thenAnswer((_) async => const Right(testJokes));

      bloc.add(const GetJokeForCategory(testTextCategory));

      await untilCalled(mockGetRandomCategoryJokes(any));

      verify(mockGetRandomCategoryJokes(
          const ParamsRandomCategory(category: testTextCategory)));
    });

    test("Should emit [Loading, Loaded] when data is gotten successfully",
        () async {
      when(mockGetRandomCategoryJokes(any))
          .thenAnswer((_) async => const Right(testJokes));

      final expected = [
        Empty(),
        Loading(),
        const Loaded(jokes: testJokes),
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(const GetJokeForCategory(testTextCategory));
    });

    test("Should emit [Loading, Error] when getting data fails", () async {
      when(mockGetRandomCategoryJokes(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      final expected = [
        Empty(),
        Loading(),
        const Error(message: SERVER_FAILURE_MESSAGE)
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(const GetJokeForCategory(testTextCategory));
    });

    test(
        "Should emit [Loading, Error] when a proper message for the error when getting data",
        () async {
      when(mockGetRandomCategoryJokes(any))
          .thenAnswer((_) async => Left(CacheFailure()));

      final expected = [
        Empty(),
        Loading(),
        const Error(message: CACHE_FAILURE_MESSAGE)
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(const GetJokeForCategory(testTextCategory));
    });
  });

  group('GetWithTextJokes', () {
    const testTextSearch = 'any search';

    const testJokes = Jokes(jokeText: 'Test joke');

    test("Should get data from the GetRandomCategoryJokes use case", () async {
      when(mockGetWithTextJokes(any))
          .thenAnswer((_) async => const Right(testJokes));

      bloc.add(const GetJokeForSearch(testTextSearch));

      await untilCalled(mockGetWithTextJokes(any));

      verify(mockGetWithTextJokes(const Params(text: testTextSearch)));
    });

    test("Should emit [Loading, Loaded] when data is gotten successfully",
        () async {
      when(mockGetWithTextJokes(any))
          .thenAnswer((_) async => const Right(testJokes));

      final expected = [
        Empty(),
        Loading(),
        const Loaded(jokes: testJokes),
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(const GetJokeForSearch(testTextSearch));
    });

    test("Should emit [Loading, Error] when getting data fails", () async {
      when(mockGetWithTextJokes(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      final expected = [
        Empty(),
        Loading(),
        const Error(message: SERVER_FAILURE_MESSAGE)
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(const GetJokeForSearch(testTextSearch));
    });

    test(
        "Should emit [Loading, Error] when a proper message for the error when getting data",
        () async {
      when(mockGetWithTextJokes(any))
          .thenAnswer((_) async => Left(CacheFailure()));

      final expected = [
        Empty(),
        Loading(),
        const Error(message: CACHE_FAILURE_MESSAGE)
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(const GetJokeForSearch(testTextSearch));
    });
  });

  group('GetRandomJokes', () {
    test("Should get data from the random use case", () async {
      const testJokes = Jokes(jokeText: 'Test joke');

      when(mockGetRandomJokes(any))
          .thenAnswer((_) async => const Right(testJokes));

      bloc.add(GetJokeForRandom());

      await untilCalled(mockGetRandomJokes(any));
    });
  });
}
