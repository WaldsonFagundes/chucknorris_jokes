import 'package:chucknorris_jokes/core/core_e.dart';
import 'package:chucknorris_jokes/features/jokes/jokes_e.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'get_categories_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CategoriesRepository>()])
void main() {
  late GetCategories usecase;
  late MockCategoriesRepository mockCategoriesRepository;

  setUp(() {
    mockCategoriesRepository = MockCategoriesRepository();
    usecase = GetCategories(mockCategoriesRepository);
  });

  const testCategories = Categories(names: ['test category']);

  test("Should get categories from the repository", () async {
    when(mockCategoriesRepository.getCategories())
        .thenAnswer((_) async => const Right(testCategories));

    final result = await usecase(NoParams());

    expect(result, const Right(testCategories));
    verify(mockCategoriesRepository.getCategories());
    verifyNoMoreInteractions(mockCategoriesRepository);
  });

  test("Should return server failure when repository call is unsuccessful", () async {
    when(mockCategoriesRepository.getCategories())
        .thenAnswer((_) async => Left(ServerFailure()));

    final result = await usecase(NoParams());

    expect(result, Left(ServerFailure()));
    verify(mockCategoriesRepository.getCategories());
    verifyNoMoreInteractions(mockCategoriesRepository);
  });

  test("Should return network failure when repository call is unsuccessful", () async {
    when(mockCategoriesRepository.getCategories())
        .thenAnswer((_) async => Left(NetworkFailure()));

    final result = await usecase(NoParams());

    expect(result, Left(NetworkFailure()));
    verify(mockCategoriesRepository.getCategories());
    verifyNoMoreInteractions(mockCategoriesRepository);
  });
}
