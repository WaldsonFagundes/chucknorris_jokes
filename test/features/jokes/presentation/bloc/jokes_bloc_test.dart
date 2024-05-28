// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:chucknorris_jokes/core/core_e.dart';
import 'package:chucknorris_jokes/features/jokes/jokes_e.dart';
import 'jokes_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<GetJokeByCategory>()])
@GenerateNiceMocks([MockSpec<GetJokeBySearch>()])
@GenerateNiceMocks([MockSpec<GetRandomJoke>()])
@GenerateNiceMocks([MockSpec<GetCategories>()])
void main() {
  late MockGetJokeByCategory mockGetRandomCategoryJokes;
  late MockGetJokeBySearch mockGetWithTextJokes;
  late MockGetRandomJoke mockGetRandomJokes;
  late JokeBloc bloc;

  setUp(() {
    mockGetRandomCategoryJokes = MockGetJokeByCategory();
    mockGetWithTextJokes = MockGetJokeBySearch();
    mockGetRandomJokes = MockGetRandomJoke();

    bloc = JokeBloc(
      getJokeByCategory: mockGetRandomCategoryJokes,
      getRandomJoke: mockGetRandomJokes,
      getJokeBySearch: mockGetWithTextJokes,
    );
  });

  test("initialState should be Empty ", () {
    expect(bloc.state, equals(JokeInitialState()));
  });

  group('GetRandomCategoryJokes', () {
    const testTextCategory = 'any category';

    const testJokes = Joke(jokeText: 'Test joke');

    test("Should get data from the GetRandomCategoryJokes use case", () async {
      when(mockGetRandomCategoryJokes(any))
          .thenAnswer((_) async => const Right(testJokes));

      bloc.add(const FetchJokeByCategory(testTextCategory));

      await untilCalled(mockGetRandomCategoryJokes(any));

      verify(mockGetRandomCategoryJokes(
          const CategoryParams(category: testTextCategory)));
    });

    test("Should emit [Loading, Loaded] when data is gotten successfully",
        () async {
      when(mockGetRandomCategoryJokes(any))
          .thenAnswer((_) async => const Right(testJokes));

      final expected = [
        JokeInitialState(),
        JokeLoading(),
        const JokeLoaded(jokes: testJokes),
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(const FetchJokeByCategory(testTextCategory));
    });

    test("Should emit [Loading, Error] when getting data fails", () async {
      when(mockGetRandomCategoryJokes(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      final expected = [
        JokeInitialState(),
        JokeLoading(),
        const JokeError(message: serverFailureMessage)
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(const FetchJokeByCategory(testTextCategory));
    });

    test(
        "Should emit [Loading, Error] when a proper message for the error when getting data",
        () async {
      when(mockGetRandomCategoryJokes(any))
          .thenAnswer((_) async => Left(CacheFailure()));

      final expected = [
        JokeInitialState(),
        JokeLoading(),
        const JokeError(message: cacheFailureMessage)
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(const FetchJokeByCategory(testTextCategory));
    });
  });

  group('GetWithTextJokes', () {
    const testTextSearch = 'any search';

    const testJokes = Joke(jokeText: 'Test joke');

    test("Should get data from the GetRandomCategoryJokes use case", () async {
      when(mockGetWithTextJokes(any))
          .thenAnswer((_) async => const Right(testJokes));

      bloc.add(const FetchJokeBySearch(testTextSearch));

      await untilCalled(mockGetWithTextJokes(any));

      verify(mockGetWithTextJokes(const SearchParams(text: testTextSearch)));
    });

    test("Should emit [Loading, Loaded] when data is gotten successfully",
        () async {
      when(mockGetWithTextJokes(any))
          .thenAnswer((_) async => const Right(testJokes));

      final expected = [
        JokeInitialState(),
        JokeLoading(),
        const JokeLoaded(jokes: testJokes),
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(const FetchJokeBySearch(testTextSearch));
    });

    test("Should emit [Loading, Error] when getting data fails", () async {
      when(mockGetWithTextJokes(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      final expected = [
        JokeInitialState(),
        JokeLoading(),
        const JokeError(message: serverFailureMessage)
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(const FetchJokeBySearch(testTextSearch));
    });

    test(
        "Should emit [Loading, Error] when a proper message for the error when getting data",
        () async {
      when(mockGetWithTextJokes(any))
          .thenAnswer((_) async => Left(CacheFailure()));

      final expected = [
        JokeInitialState(),
        JokeLoading(),
        const JokeError(message: cacheFailureMessage)
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(const FetchJokeBySearch(testTextSearch));
    });
  });

  group('GetRandomJokes', () {
    const testJokes = Joke(jokeText: 'Test joke');

    test("Should get data from the random use case", () async {
      when(mockGetRandomJokes(any))
          .thenAnswer((_) async => const Right(testJokes));

      bloc.add(FetchRandomJoke());

      await untilCalled(mockGetRandomJokes(any));
    });

    test("Should emit [Loading, Loaded] when data is gotten successfully",
        () async {
      when(mockGetRandomJokes(any))
          .thenAnswer((_) async => const Right(testJokes));

      final expected = [
        JokeInitialState(),
        JokeLoading(),
        const JokeLoaded(jokes: testJokes),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(FetchRandomJoke());
    });
    test("Should emit [Loading, Error] when getting data fails", () async {
      when(mockGetRandomJokes(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      final expected = [
        JokeInitialState(),
        JokeLoading(),
        const JokeError(message: serverFailureMessage)
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(FetchRandomJoke());
    });

    test(
        "Should emit [Loading, Error] when a proper message for the error when getting data",
        () async {
      when(mockGetRandomJokes(any))
          .thenAnswer((_) async => Left(CacheFailure()));

      final expected = [
        JokeInitialState(),
        JokeLoading(),
        const JokeError(message: cacheFailureMessage)
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(FetchRandomJoke());
    });
  });
}
