// Project imports:
import '../../domain/domain_e.dart';

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
