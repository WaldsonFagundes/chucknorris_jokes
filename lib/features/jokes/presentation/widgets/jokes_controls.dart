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
  String? selecetedValue;
  late List<String> options = [];

  @override
  void initState() {
    BlocProvider.of<CategoriesBloc>(context).add(FetchCategories());
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchField(),
        const SizedBox(height: 10),
        _buildSearchButton(),
        const SizedBox(height: 10),
        _buildCategoryDropdown(),
        const SizedBox(height: 10),
        _buildCategoryButton(),
        const SizedBox(height: 10),
        _buildRandomButton(),
      ],
    );
  }

  ElevatedButton _buildRandomButton() =>
      ElevatedButton(onPressed: _addRandom, child: const Text('Random'));

  ElevatedButton _buildCategoryButton() {
    return ElevatedButton(
        onPressed: () {
          _addCategoryJokes(selecetedValue!);
        },
        child: const Text('by categories'));
  }

  BlocConsumer<CategoriesBloc, CategoriesState> _buildCategoryDropdown() {
    return BlocConsumer<CategoriesBloc, CategoriesState>(
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
    );
  }

  ElevatedButton _buildSearchButton() {
    return ElevatedButton(
        onPressed: () {
          _addSearchJokes(controller.text);
        },
        child: const Text('by Search'));
  }

  Widget _buildSearchField() {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), hintText: 'Search'),
    );
  }

  void _addCategoryJokes(String category) {
    controller.clear();
    BlocProvider.of<JokeBloc>(context).add(FetchJokeByCategory(category));
  }

  void _addSearchJokes(String textSearch) {
    controller.clear();
    BlocProvider.of<JokeBloc>(context).add(FetchJokeBySearch(textSearch));
  }

  void _addRandom() {
    controller.clear();
    BlocProvider.of<JokeBloc>(context).add(FetchRandomJoke());
  }
}
