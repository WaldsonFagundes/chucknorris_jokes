// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import '../../../../injection_container.dart';
import '../blocs/blocs_e.dart';
import '../widgets/widget_e.dart';

class JokesPage extends StatelessWidget {
  const JokesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jokes'),
      ),
      body: SingleChildScrollView(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => sl<JokeBloc>(),
            ),
            BlocProvider(
              create: (_) => sl<CategoriesBloc>(),
            ),
          ],
          child: buildBody(context),
        ),
      ),
    );
  }
}

Widget buildBody(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const SizedBox(
            height: 10.0,
          ),
          BlocConsumer<JokeBloc, JokeState>(
            listener: (context, state) {
              if (state is JokeError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              if (state is JokeInitialState) {
                return const MessageDisplay(message: 'Start Searching');
              } else if (state is JokeLoading) {
                return const LoadingWidget();
              } else if (state is JokeLoaded) {
                return JokeDisplay(
                  jokes: state.jokes,
                );
              } else {
                return const MessageDisplay(message: 'Something went wrong!');
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          const JokesControls(),
        ],
      ),
    ),
  );
}
