// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import '../blocs/blocs_e.dart';

class JokesControls extends StatefulWidget {
  const JokesControls({super.key});

  @override
  State<JokesControls> createState() => _JokesControlsState();
}

class _JokesControlsState extends State<JokesControls> {
  final controller = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<CategoriesBloc>(context).add(FetchCategories());
    super.initState();
  }

  String? selecetedValue;

  late List<String> options = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          decoration: const InputDecoration(
              border: OutlineInputBorder(), hintText: 'Search'),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
            onPressed: () {
              addSearchJokes(controller.text);
            },
            child: const Text('by Search')),
        const SizedBox(
          height: 10,
        ),
        BlocConsumer<CategoriesBloc, CategoriesState>(
          builder: (context, state) {
            if (state is CategoriesInitialState) {
              return const Text('Categorias');
            } else if (state is CategoriesLoading) {
              return const Text('Carregado...');
            } else if (state is CategoriesLoaded) {
              options = state.categories.names;
              return DropdownButton<String>(
                hint: const Text('Selecione uma opção'),
                value: selecetedValue,
                onChanged: (String? newValue) {
                  setState(() {
                    selecetedValue = newValue;
                  });
                },
                items: options.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              );
            } else {
              return Container();
            }
          },
          listener: (context, state) {
            if (state is CategoriesError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
            onPressed: () {
              addCategoryJokes(selecetedValue!);
            },
            child: const Text('by categories')),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(onPressed: addRandom, child: const Text('Random')),
      ],
    );
  }

  void addCategoryJokes(String category) {
    controller.clear();
    BlocProvider.of<JokeBloc>(context).add(FetchJokeByCategory(category));
  }

  void addSearchJokes(String textSearch) {
    controller.clear();
    BlocProvider.of<JokeBloc>(context).add(FetchJokeBySearch(textSearch));
  }

  void addRandom() {
    controller.clear();
    BlocProvider.of<JokeBloc>(context).add(FetchRandomJoke());
  }
}
