import 'package:bloc/bloc.dart';
import 'package:chucknorris_jokes/features/jokes/presentation/blocs/categories_bloc/categories_event.dart';
import 'package:chucknorris_jokes/features/jokes/presentation/blocs/categories_bloc/categories_state.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/usecases/get_categories.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_CATEGORY_FAILURE_MESSAGE = 'Invalid category';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetCategories getCategories;

  CategoriesBloc({required this.getCategories})
      : super(CategoriesInitialState()) {
    on<CategoriesEvent>((event, emit) async {
      if (event is FetchCategories) {
        emit(CategoriesInitialState());
        emit(CategoriesLoading());
        final failureOrCategories = await getCategories(CategoriesNoParams());

        emit(failureOrCategories.fold(
            (failure) =>
                CategoriesError(message: _mapFailureToMessage(failure)),
            (categories) => CategoriesLoaded(categories: categories)));
      }
    });
  }
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    default:
      return 'Unexpected error';
  }
}
