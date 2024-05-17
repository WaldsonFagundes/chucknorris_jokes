import 'package:chucknorris_jokes/core/error/execeptions.dart';
import 'package:chucknorris_jokes/core/error/failures.dart';
import 'package:chucknorris_jokes/core/network/network_info.dart';
import 'package:chucknorris_jokes/features/jokes/data/datasources/jokes_local_data_source.dart';
import 'package:chucknorris_jokes/features/jokes/data/datasources/jokes_remote_data_source.dart';
import 'package:chucknorris_jokes/features/jokes/data/models/jokes_model.dart';
import 'package:chucknorris_jokes/features/jokes/data/repositories/jokes_repository_impl.dart';
import 'package:chucknorris_jokes/features/jokes/domain/entities/jokes.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'jokes_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<JokesRemoteDataSource>()])
@GenerateNiceMocks([MockSpec<JokesLocalDataSource>()])
@GenerateNiceMocks([MockSpec<NetworkInfo>()])
void main() {
  late JokesRepositoryImpl repository;
  late MockJokesRemoteDataSource mockRemoteDataSource;
  late MockJokesLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockJokesRemoteDataSource();
    mockLocalDataSource = MockJokesLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();

    repository = JokesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

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

  group('getRandomCategoryJokes', () {
    const testCategory = 'any category';
    const testJokeModel = JokesModel(jokeText: 'test text');
    const Jokes testJoke = testJokeModel;

    runTestsOnline(() {
      test(
          "Should return remote data WHEN the call to remote data is successfull ",
          () async {
        when(mockRemoteDataSource.getRandomCategoryJokes(any))
            .thenAnswer((_) async => testJokeModel);

        final result = await repository.getRandomCategoryJokes(testCategory);

        verify(mockRemoteDataSource.getRandomCategoryJokes(testCategory));
        expect(result, equals(const Right(testJoke)));
      });

      test(
          "Should cache the data locally when the call to remote data source is successfull ",
          () async {
        when(mockRemoteDataSource.getRandomCategoryJokes(any))
            .thenAnswer((_) async => testJokeModel);

        await repository.getRandomCategoryJokes(testCategory);

        verify(mockRemoteDataSource.getRandomCategoryJokes(testCategory));
        verify(mockLocalDataSource.cacheJoke(testJokeModel));
      });

      test(
          "Should return server failure when the call to remote data source is unsuccessful ",
          () async {
        when(mockRemoteDataSource.getRandomCategoryJokes(any))
            .thenThrow(ServerException());

        final result = await repository.getRandomCategoryJokes(testCategory);

        verify(mockRemoteDataSource.getRandomCategoryJokes(testCategory));
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

        final result = await repository.getRandomCategoryJokes(testCategory);

        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastJoke());
        expect(result, equals(const Right(testJoke)));
      });

      test("Should return CacheFailure When there is no cached data present",
          () async {
        when(mockLocalDataSource.getLastJoke()).thenThrow(CacheException());

        final result = await repository.getRandomCategoryJokes(testCategory);

        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastJoke());
        expect(result, equals(left(CacheFailure())));
      });
    });
  });
  group('getWithTextJokes', () {
    const testTextSearch = 'any search';
    const testJokeModel = JokesModel(jokeText: 'test text');
    const Jokes testJoke = testJokeModel;

    runTestsOnline(() {
      test(
          "Should return remote data WHEN the call to remote data is successfull ",
              () async {
            when(mockRemoteDataSource.getWithTextJokes(any))
                .thenAnswer((_) async => testJokeModel);

            final result = await repository.getWithTextJokes(testTextSearch);

            verify(mockRemoteDataSource.getWithTextJokes(testTextSearch));
            expect(result, equals(const Right(testJoke)));
          });

      test(
          "Should cache the data locally when the call to remote data source is successfull ",
              () async {
            when(mockRemoteDataSource.getWithTextJokes(any))
                .thenAnswer((_) async => testJokeModel);

            await repository.getWithTextJokes(testTextSearch);

            verify(mockRemoteDataSource.getWithTextJokes(testTextSearch));
            verify(mockLocalDataSource.cacheJoke(testJokeModel));
          });

      test(
          "Should return server failure when the call to remote data source is unsuccessful ",
              () async {
            when(mockRemoteDataSource.getWithTextJokes(any))
                .thenThrow(ServerException());

            final result = await repository.getWithTextJokes(testTextSearch);

            verify(mockRemoteDataSource.getWithTextJokes(testTextSearch));
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

            final result = await repository.getWithTextJokes(testTextSearch);

            verifyZeroInteractions(mockRemoteDataSource);
            verify(mockLocalDataSource.getLastJoke());
            expect(result, equals(const Right(testJoke)));
          });

      test("Should return CacheFailure When there is no cached data present",
              () async {
            when(mockLocalDataSource.getLastJoke()).thenThrow(CacheException());

            final result = await repository.getWithTextJokes(testTextSearch);

            verifyZeroInteractions(mockRemoteDataSource);
            verify(mockLocalDataSource.getLastJoke());
            expect(result, equals(left(CacheFailure())));
          });
    });
  });
  group('getRandomJokes', () {
    const testJokeModel = JokesModel(jokeText: 'test text');
    const Jokes testJoke = testJokeModel;

    runTestsOnline(() {
      test(
          "Should return remote data WHEN the call to remote data is successfull ",
              () async {
            when(mockRemoteDataSource.getRandomJokes())
                .thenAnswer((_) async => testJokeModel);

            final result = await repository.getRandomJokes();

            verify(mockRemoteDataSource.getRandomJokes());
            expect(result, equals(const Right(testJoke)));
          });

      test(
          "Should cache the data locally when the call to remote data source is successfull ",
              () async {
            when(mockRemoteDataSource.getRandomJokes())
                .thenAnswer((_) async => testJokeModel);

            await repository.getRandomJokes();

            verify(mockRemoteDataSource.getRandomJokes());
            verify(mockLocalDataSource.cacheJoke(testJokeModel));
          });

      test(
          "Should return server failure when the call to remote data source is unsuccessful ",
              () async {
            when(mockRemoteDataSource.getRandomJokes())
                .thenThrow(ServerException());

            final result = await repository.getRandomJokes();

            verify(mockRemoteDataSource.getRandomJokes());
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
