import 'package:chucknorris_jokes/features/jokes/presentation/blocs/categories_bloc/categories_bloc.dart';
import 'package:chucknorris_jokes/features/jokes/presentation/widgets/jokes_controls.dart';
import 'package:chucknorris_jokes/features/jokes/presentation/widgets/loading_widget.dart';
import 'package:chucknorris_jokes/features/jokes/presentation/widgets/message_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../blocs/joke_bloc/joke_bloc.dart';
import '../blocs/joke_bloc/joke_state.dart';
import '../widgets/joke_display.dart';

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
                return Container();
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
         JokesControls(),
        ],
      ),
    ),
  );
}

/*
class JokesPage extends StatelessWidget {
  const JokesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jokes'),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }
}

BlocProvider<JokeBloc> buildBody(BuildContext context) {
  return BlocProvider(
    create: (_) => sl<JokeBloc>(),
    child: Center(
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
                  return Container();
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            JokesControls(),
          ],
        ),
      ),
    ),
  );
}
*/
