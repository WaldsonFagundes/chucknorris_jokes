import '../../domain/entities/jokes.dart';

class JokesModel extends Jokes {
  const JokesModel({
    required super.jokeText,
  });

  factory JokesModel.fromJson(Map<String, dynamic> json) {
    return JokesModel(
      jokeText: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'value': jokeText};
  }
}
