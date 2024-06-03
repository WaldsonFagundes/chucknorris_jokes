import 'package:chucknorris_jokes/core/core_e.dart';
import 'package:chucknorris_jokes/core/network/network_info.dart';
import 'package:chucknorris_jokes/features/jokes/jokes_e.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'categories_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CategoriesRemoteDataSource>()])
@GenerateNiceMocks([MockSpec<NetworkInfo>()])
void main() {
  late CategoriesRepositoryImpl repository;
  late MockCategoriesRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockRemoteDataSource = MockCategoriesRemoteDataSource();

    repository = CategoriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  const testCategoriesModel = CategoriesModel(names: ['test category']);
  const Categories testCategories = testCategoriesModel;

  void runTestOnline(Function body) {
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

  runTestOnline(() {
    test("Should return remote data when the call to remote data is successful",
        () async {
      when(mockRemoteDataSource.getCategories())
          .thenAnswer((_) async => testCategoriesModel);

      final result = await repository.getCategories();

      verify(mockRemoteDataSource.getCategories());
      expect(result, equals(const Right(testCategories)));
    });
    test(
        "Should return server failure when the call to remote data is unsuccessful",
        () async {
      when(mockRemoteDataSource.getCategories()).thenThrow(ServerException());

      final result = await repository.getCategories();

      verify(mockRemoteDataSource.getCategories());
      expect(result, equals(Left(ServerFailure())));
    });
  });

  runTestOffline(() {
    test(
        "Should return server failure when the call to remote data is unsuccessful",
        () async {
      final result = await repository.getCategories();

      expect(result, equals(Left(NetworkFailure())));
    });
  });
}
