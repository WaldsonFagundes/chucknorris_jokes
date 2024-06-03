// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:chucknorris_jokes/core/core_e.dart';
import 'package:chucknorris_jokes/features/jokes/jokes_e.dart';
import 'joke_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<GetJokeByCategory>()])
@GenerateNiceMocks([MockSpec<GetJokeBySearch>()])
@GenerateNiceMocks([MockSpec<GetRandomJoke>()])

void main() {
  late MockGetJokeByCategory mockGetJokeByCategory;
  late MockGetJokeBySearch mockGetJokeBySearch;
  late MockGetRandomJoke mockGetRandomJoke;
  late JokeBloc bloc;

  setUp(() {
    mockGetJokeByCategory = MockGetJokeByCategory();
    mockGetJokeBySearch = MockGetJokeBySearch();
    mockGetRandomJoke = MockGetRandomJoke();

    bloc = JokeBloc(
      getJokeByCategory: mockGetJokeByCategory,
      getRandomJoke: mockGetRandomJoke,
      getJokeBySearch: mockGetJokeBySearch,
    );
  });

  const testJokes = Joke(jokeText: 'Test joke');
  const testTextCategory = 'any category';
  const testTextSearch = 'any search';

  void setUpMockSuccess({
    required Future<Either<Failure, Joke>> Function() function,
  }) {
    when(function()).thenAnswer((_) async => const Right(testJokes));
  }

  void setUpMockFailure({
    required Future<Either<Failure, Joke>> Function() function,
    required Failure failure,
  }) {
    when(function()).thenAnswer((_) async => Left(failure));
  }

  test("initialState should be JokeInitialState", () {
    expect(bloc.state, equals(JokeInitialState()));
  });

  group('GetJokeByCategory', () {
    setUp(() {
      setUpMockSuccess(function: () => mockGetJokeByCategory(any));
    });

    test("Should get data from the GetJokeByCategory use case", () async {
      bloc.add(const FetchJokeByCategory(testTextCategory));

      await untilCalled(mockGetJokeByCategory(any));

      verify(mockGetJokeByCategory(
          const CategoryParams(category: testTextCategory)));
    });

    test("Should emit [Loading, Loaded] when data is gotten successfully",
        () async {
      final expected = [
        JokeLoading(),
        const JokeLoaded(jokes: testJokes),
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(const FetchJokeByCategory(testTextCategory));
    });

    test("Should emit [Loading, Error] when getting data fails", () async {
      setUpMockFailure(
          function: () => mockGetJokeByCategory(any), failure: ServerFailure());

      final expected = [
        JokeLoading(),
        const JokeError(message: serverFailureMessage)
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(const FetchJokeByCategory(testTextCategory));
    });

    test(
        "Should emit [Loading, Error] when a proper message for the error when getting data",
        () async {
      setUpMockFailure(
          function: () => mockGetJokeByCategory(any), failure: CacheFailure());

      final expected = [
        JokeLoading(),
        const JokeError(message: cacheFailureMessage)
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(const FetchJokeByCategory(testTextCategory));
    });
  });

  group('GetJokeBySearch', () {
    setUp(() {
      setUpMockSuccess(function: () => mockGetJokeBySearch(any));
    });
    test("Should get data from the GetJokeBySearch use case", () async {
      bloc.add(const FetchJokeBySearch(testTextSearch));

      await untilCalled(mockGetJokeBySearch(any));

      verify(mockGetJokeBySearch(const SearchParams(text: testTextSearch)));
    });

    test("Should emit [Loading, Loaded] when data is gotten successfully",
        () async {
      final expected = [
        JokeLoading(),
        const JokeLoaded(jokes: testJokes),
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(const FetchJokeBySearch(testTextSearch));
    });

    test("Should emit [Loading, Error] when getting data fails", () async {
      setUpMockFailure(
          function: () => mockGetJokeBySearch(any), failure: ServerFailure());

      final expected = [
        JokeLoading(),
        const JokeError(message: serverFailureMessage)
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(const FetchJokeBySearch(testTextSearch));
    });

    test(
        "Should emit [Loading, Error] when a proper message for the error when getting data",
        () async {
      setUpMockFailure(
          function: () => mockGetJokeBySearch(any), failure: CacheFailure());

      final expected = [
        JokeLoading(),
        const JokeError(message: cacheFailureMessage)
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(const FetchJokeBySearch(testTextSearch));
    });
  });

  group('GetRandomJoke', () {
    setUp(() {
      setUpMockSuccess(function: () => mockGetRandomJoke(any));
    });

    test("Should get data from the random use case", () async {
      bloc.add(FetchRandomJoke());

      await untilCalled(mockGetRandomJoke(any));
    });

    test("Should emit [Loading, Loaded] when data is gotten successfully",
        () async {
      final expected = [
        JokeLoading(),
        const JokeLoaded(jokes: testJokes),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(FetchRandomJoke());
    });
    test("Should emit [Loading, Error] when getting data fails", () async {
      setUpMockFailure(
          function: () => mockGetRandomJoke(any), failure: ServerFailure());

      final expected = [
        JokeLoading(),
        const JokeError(message: serverFailureMessage)
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(FetchRandomJoke());
    });

    test(
        "Should emit [Loading, Error] when a proper message for the error when getting data",
        () async {
      setUpMockFailure(
          function: () => mockGetRandomJoke(any), failure: CacheFailure());

      final expected = [
        JokeLoading(),
        const JokeError(message: cacheFailureMessage)
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(FetchRandomJoke());
    });
  });
}
