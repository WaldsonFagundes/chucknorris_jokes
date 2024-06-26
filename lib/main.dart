// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'features/jokes/presentation/page/page_e.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Number Trivia',
      home: JokesPage(),
    );
  }
}
