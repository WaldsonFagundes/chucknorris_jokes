// Mocks generated by Mockito 5.4.4 from annotations
// in chucknorris_jokes/test/features/jokes/data/repositories/jokes_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:chucknorris_jokes/core/network/network_info.dart' as _i6;
import 'package:chucknorris_jokes/features/jokes/data/datasources/joke_local_data_source.dart'
    as _i5;
import 'package:chucknorris_jokes/features/jokes/data/datasources/joke_remote_data_source.dart'
    as _i3;
import 'package:chucknorris_jokes/features/jokes/data/models/joke_model.dart'
    as _i2;
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

class _FakeJokeModel_0 extends _i1.SmartFake implements _i2.JokeModel {
  _FakeJokeModel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [JokeRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockJokeRemoteDataSource extends _i1.Mock
    implements _i3.JokeRemoteDataSource {
  @override
  _i4.Future<_i2.JokeModel> getRandomJoke() => (super.noSuchMethod(
        Invocation.method(
          #getRandomJoke,
          [],
        ),
        returnValue: _i4.Future<_i2.JokeModel>.value(_FakeJokeModel_0(
          this,
          Invocation.method(
            #getRandomJoke,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.JokeModel>.value(_FakeJokeModel_0(
          this,
          Invocation.method(
            #getRandomJoke,
            [],
          ),
        )),
      ) as _i4.Future<_i2.JokeModel>);

  @override
  _i4.Future<_i2.JokeModel> getJokesByCategory(String? category) =>
      (super.noSuchMethod(
        Invocation.method(
          #getJokesByCategory,
          [category],
        ),
        returnValue: _i4.Future<_i2.JokeModel>.value(_FakeJokeModel_0(
          this,
          Invocation.method(
            #getJokesByCategory,
            [category],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.JokeModel>.value(_FakeJokeModel_0(
          this,
          Invocation.method(
            #getJokesByCategory,
            [category],
          ),
        )),
      ) as _i4.Future<_i2.JokeModel>);

  @override
  _i4.Future<_i2.JokeModel> getJokeBySearch(String? textSearch) =>
      (super.noSuchMethod(
        Invocation.method(
          #getJokeBySearch,
          [textSearch],
        ),
        returnValue: _i4.Future<_i2.JokeModel>.value(_FakeJokeModel_0(
          this,
          Invocation.method(
            #getJokeBySearch,
            [textSearch],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.JokeModel>.value(_FakeJokeModel_0(
          this,
          Invocation.method(
            #getJokeBySearch,
            [textSearch],
          ),
        )),
      ) as _i4.Future<_i2.JokeModel>);
}

/// A class which mocks [JokeLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockJokeLocalDataSource extends _i1.Mock
    implements _i5.JokeLocalDataSource {
  @override
  _i4.Future<_i2.JokeModel> getLastJoke() => (super.noSuchMethod(
        Invocation.method(
          #getLastJoke,
          [],
        ),
        returnValue: _i4.Future<_i2.JokeModel>.value(_FakeJokeModel_0(
          this,
          Invocation.method(
            #getLastJoke,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.JokeModel>.value(_FakeJokeModel_0(
          this,
          Invocation.method(
            #getLastJoke,
            [],
          ),
        )),
      ) as _i4.Future<_i2.JokeModel>);

  @override
  _i4.Future<void> cacheJoke(_i2.JokeModel? jokesCache) => (super.noSuchMethod(
        Invocation.method(
          #cacheJoke,
          [jokesCache],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i6.NetworkInfo {
  @override
  _i4.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i4.Future<bool>.value(false),
        returnValueForMissingStub: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
}
