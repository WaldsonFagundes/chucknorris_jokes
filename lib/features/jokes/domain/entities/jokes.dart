import 'package:equatable/equatable.dart';

class Jokes  extends Equatable {
  final String jokeText;

  const Jokes({required this.jokeText});

  @override
  List<Object?> get props => [jokeText];
}
