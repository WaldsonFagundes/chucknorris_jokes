// Package imports:
import 'package:bloc/bloc.dart';

// Project imports:
import '../../../../../core/core_e.dart';
import '../../../domain/usecases/usecases_e.dart';
import 'categories_bloc_e.dart';

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
      return serverFailureMessage;
    case CacheFailure:
      return cacheFailureMessage;
    default:
      return 'Unexpected error';
  }
}
