// Project imports:
import '../../domain/domain_e.dart';

class JokeModel extends Joke {
  const JokeModel({
    required super.jokeText,
  });

  static const String _valueKey = 'value';

  factory JokeModel.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey(_valueKey)) {
      throw const FormatException("missing key: $_valueKey");
    }
    return JokeModel(
      jokeText: json[_valueKey],
    );
  }

  Map<String, dynamic> toJson() {
    return {_valueKey: jokeText};
  }
}
