abstract class Failure {
  final List _properties;

  const Failure([this._properties = const <dynamic> []]);

}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

