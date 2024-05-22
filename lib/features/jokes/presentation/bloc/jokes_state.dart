
import 'package:equatable/equatable.dart';

import '../../domain/entities/jokes.dart';

abstract class JokeState extends Equatable {
  const JokeState();

  @override
  List<Object?> get props => [];
}


class Empty extends JokeState {}

class Loading extends JokeState {}

class Loaded extends JokeState {
  final Jokes jokes;

  const Loaded({required this.jokes});

}

class Error extends JokeState {
  final String message;

  const Error({required this.message});

  @override
  List<Object?> get props => [message];
}
