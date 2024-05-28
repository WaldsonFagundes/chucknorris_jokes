// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../domain/entities/entities_e.dart';

class JokeDisplay extends StatelessWidget {
  final Joke jokes;

  const JokeDisplay({
    super.key,
    required this.jokes,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Text(
                  jokes.jokeText,
                  style: const TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
