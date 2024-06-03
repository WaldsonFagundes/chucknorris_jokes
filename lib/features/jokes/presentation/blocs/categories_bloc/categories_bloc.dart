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
    on<FetchCategories>(_onFetchCategories);
  }

  Future<void> _onFetchCategories(
      FetchCategories event, Emitter<CategoriesState> emit) async {
    emit(CategoriesLoading());
    final failureOrCategories = await getCategories(NoParams());

    emit(failureOrCategories.fold(
        (failure) => CategoriesError(message: _mapFailureToMessage(failure)),
        (categories) => CategoriesLoaded(categories: categories)));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case NetworkFailure:
        return networkFailureMessage;
      default:
        return 'Unexpected error';
    }
  }
}
