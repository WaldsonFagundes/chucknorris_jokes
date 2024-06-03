// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:chucknorris_jokes/core/core_e.dart';
import 'package:chucknorris_jokes/features/jokes/jokes_e.dart';
import 'joke_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<JokeRemoteDataSource>()])
@GenerateNiceMocks([MockSpec<JokeLocalDataSource>()])
@GenerateNiceMocks([MockSpec<NetworkInfo>()])
void main() {
  late JokeRepositoryImpl repository;
  late MockJokeRemoteDataSource mockRemoteDataSource;
  late MockJokeLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockJokeRemoteDataSource();
    mockLocalDataSource = MockJokeLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();

    repository = JokeRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  const testJokeModel = JokeModel(jokeText: 'test text');
  const Joke testJoke = testJokeModel;

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('getJokeByCategory', () {
    const testCategory = 'any category';

    runTestsOnline(() {
      test(
          "Should return remote data when the call to remote data is successful",
          () async {
        when(mockRemoteDataSource.getJokesByCategory(any))
            .thenAnswer((_) async => testJokeModel);

        final result = await repository.getJokeByCategory(testCategory);

        verify(mockRemoteDataSource.getJokesByCategory(testCategory));
        expect(result, equals(const Right(testJoke)));
      });

      test(
          "Should cache the data locally when the call to remote data source is successful ",
          () async {
        when(mockRemoteDataSource.getJokesByCategory(any))
            .thenAnswer((_) async => testJokeModel);

        await repository.getJokeByCategory(testCategory);

        verify(mockRemoteDataSource.getJokesByCategory(testCategory));
        verify(mockLocalDataSource.cacheJoke(testJokeModel));
      });

      test(
          "Should return server failure when the call to remote data source is unsuccessful ",
          () async {
        when(mockRemoteDataSource.getJokesByCategory(any))
            .thenThrow(ServerException());

        final result = await repository.getJokeByCategory(testCategory);

        verify(mockRemoteDataSource.getJokesByCategory(testCategory));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });
    runTestOffline(() {
      test(
          "Should return last locally cached data when the cached data is present",
          () async {
        when(mockLocalDataSource.getLastJoke())
            .thenAnswer((_) async => testJokeModel);

        final result = await repository.getJokeByCategory(testCategory);

        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastJoke());
        expect(result, equals(const Right(testJoke)));
      });

      test("Should return cache failure when there is no cached data present",
          () async {
        when(mockLocalDataSource.getLastJoke()).thenThrow(CacheException());

        final result = await repository.getJokeByCategory(testCategory);

        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastJoke());
        expect(result, equals(left(CacheFailure())));
      });
    });
  });
  group('getJokeBySearch', () {
    const testTextSearch = 'any search';

    runTestsOnline(() {
      test(
          "Should return remote data WHEN the call to remote data is successfull ",
          () async {
        when(mockRemoteDataSource.getJokeBySearch(any))
            .thenAnswer((_) async => testJokeModel);

        final result = await repository.getJokeBySearch(testTextSearch);

        verify(mockRemoteDataSource.getJokeBySearch(testTextSearch));
        expect(result, equals(const Right(testJoke)));
      });

      test(
          "Should cache the data locally when the call to remote data source is successfull ",
          () async {
        when(mockRemoteDataSource.getJokeBySearch(any))
            .thenAnswer((_) async => testJokeModel);

        await repository.getJokeBySearch(testTextSearch);

        verify(mockRemoteDataSource.getJokeBySearch(testTextSearch));
        verify(mockLocalDataSource.cacheJoke(testJokeModel));
      });

      test(
          "Should return server failure when the call to remote data source is unsuccessful ",
          () async {
        when(mockRemoteDataSource.getJokeBySearch(any))
            .thenThrow(ServerException());

        final result = await repository.getJokeBySearch(testTextSearch);

        verify(mockRemoteDataSource.getJokeBySearch(testTextSearch));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });
    runTestOffline(() {
      test(
          "Should return last locally cached data when the cached data is present",
          () async {
        when(mockLocalDataSource.getLastJoke())
            .thenAnswer((_) async => testJokeModel);

        final result = await repository.getJokeBySearch(testTextSearch);

        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastJoke());
        expect(result, equals(const Right(testJoke)));
      });

      test("Should return CacheFailure When there is no cached data present",
          () async {
        when(mockLocalDataSource.getLastJoke()).thenThrow(CacheException());

        final result = await repository.getJokeBySearch(testTextSearch);

        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastJoke());
        expect(result, equals(left(CacheFailure())));
      });
    });
  });
  group('getRandomJokes', () {
    runTestsOnline(() {
      test(
          "Should return remote data WHEN the call to remote data is successfull ",
          () async {
        when(mockRemoteDataSource.getRandomJoke())
            .thenAnswer((_) async => testJokeModel);

        final result = await repository.getRandomJokes();

        verify(mockRemoteDataSource.getRandomJoke());
        expect(result, equals(const Right(testJoke)));
      });

      test(
          "Should cache the data locally when the call to remote data source is successfull ",
          () async {
        when(mockRemoteDataSource.getRandomJoke())
            .thenAnswer((_) async => testJokeModel);

        await repository.getRandomJokes();

        verify(mockRemoteDataSource.getRandomJoke());
        verify(mockLocalDataSource.cacheJoke(testJokeModel));
      });

      test(
          "Should return server failure when the call to remote data source is unsuccessful ",
          () async {
        when(mockRemoteDataSource.getRandomJoke()).thenThrow(ServerException());

        final result = await repository.getRandomJokes();

        verify(mockRemoteDataSource.getRandomJoke());
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });
    runTestOffline(() {
      test(
          "Should return last locally cached data when the cached data is present",
          () async {
        when(mockLocalDataSource.getLastJoke())
            .thenAnswer((_) async => testJokeModel);

        final result = await repository.getRandomJokes();

        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastJoke());
        expect(result, equals(const Right(testJoke)));
      });

      test("Should return CacheFailure When there is no cached data present",
          () async {
        when(mockLocalDataSource.getLastJoke()).thenThrow(CacheException());

        final result = await repository.getRandomJokes();

        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastJoke());
        expect(result, equals(left(CacheFailure())));
      });
    });
  });
}
