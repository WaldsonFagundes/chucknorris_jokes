// Mocks generated by Mockito 5.4.4 from annotations
// in chucknorris_jokes/test/features/jokes/domain/usecase/get_categories_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:chucknorris_jokes/core/core_e.dart' as _i5;
import 'package:chucknorris_jokes/features/jokes/domain/entities/entities_e.dart'
    as _i6;
import 'package:chucknorris_jokes/features/jokes/domain/repositories/categories_repository.dart'
    as _i3;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [CategoriesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockCategoriesRepository extends _i1.Mock
    implements _i3.CategoriesRepository {
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Categories>> getCategories() =>
      (super.noSuchMethod(
        Invocation.method(
          #getCategories,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Categories>>.value(
            _FakeEither_0<_i5.Failure, _i6.Categories>(
          this,
          Invocation.method(
            #getCategories,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, _i6.Categories>>.value(
                _FakeEither_0<_i5.Failure, _i6.Categories>(
          this,
          Invocation.method(
            #getCategories,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Categories>>);
}
