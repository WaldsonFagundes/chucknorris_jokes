// Package imports:
import 'package:chucknorris_jokes/core/core_e.dart';
import 'package:chucknorris_jokes/features/jokes/jokes_e.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'categories_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<GetCategories>()])
void main() {
  late MockGetCategories mockGetCategories;
  late CategoriesBloc bloc;

  setUp(() {
    mockGetCategories = MockGetCategories();

    bloc = CategoriesBloc(getCategories: mockGetCategories);
  });

  const testCategories = Categories(names: ['test category']);

  test("initialState should be CategoriesInitialState", () {
    expect(bloc.state, equals(CategoriesInitialState()));
  });

  test("Should get data from the GetCategories use case", () async {
    when(mockGetCategories(any))
        .thenAnswer((_) async => const Right(testCategories));

    bloc.add(FetchCategories());

    await untilCalled(mockGetCategories(any));
  });

  test("Should emit [Loading, Loaded] when data is gotten successfully",
      () async {
    when(mockGetCategories(any))
        .thenAnswer((_) async => const Right(testCategories));

    final expected = [
      CategoriesLoading(),
      const CategoriesLoaded(categories: testCategories),
    ];
    expectLater(bloc.stream, emitsInOrder(expected));

    bloc.add(FetchCategories());
  });

  test("Should emit [Loading, Error] when getting data fails", () async {
    when(mockGetCategories(any)).thenAnswer((_) async => Left(ServerFailure()));

    final expected = [
      CategoriesLoading(),
      const CategoriesError(message: serverFailureMessage),
    ];
    expectLater(bloc.stream, emitsInOrder(expected));

    bloc.add(FetchCategories());
  });

  test("Should emit [Loading, Error] when network fails", () async {
    when(mockGetCategories(any))
        .thenAnswer((_) async => Left(NetworkFailure()));

    final expected = [
      CategoriesLoading(),
      const CategoriesError(message: networkFailureMessage),
    ];
    expectLater(bloc.stream, emitsInOrder(expected));

    bloc.add(FetchCategories());
  });
}
