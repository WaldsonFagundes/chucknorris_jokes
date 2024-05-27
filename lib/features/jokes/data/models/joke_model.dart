import '../../domain/entities/joke.dart';

class JokeModel extends Joke {
  const JokeModel({
    required super.jokeText,
  });

  factory JokeModel.fromJson(Map<String, dynamic> json) {
    return JokeModel(
      jokeText: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'value': jokeText};
  }
}
