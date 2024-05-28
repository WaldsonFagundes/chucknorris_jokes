// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import '../../../domain/entities/entities_e.dart';

abstract class JokeState extends Equatable {
  const JokeState();

  @override
  List<Object?> get props => [];
}

class JokeInitialState extends JokeState {}

class JokeLoading extends JokeState {}

class JokeLoaded extends JokeState {
  final Joke jokes;

  const JokeLoaded({required this.jokes});
}

class JokeError extends JokeState {
  final String message;

  const JokeError({required this.message});

  @override
  List<Object?> get props => [message];
}
