// Package imports:
import 'package:equatable/equatable.dart';

class Joke extends Equatable {
  final String jokeText;

  const Joke({required this.jokeText});

  @override
  List<Object?> get props => [jokeText];

  @override
  String toString() {
    return 'Joke(jokeText: $jokeText)';
  }
}
