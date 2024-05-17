// lib/bloc/repository_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/api_services.dart';
import 'repo_event.dart';
import 'repo_state.dart';
 

class RepositoryBloc extends Bloc<RepositoryEvent, RepositoryState> {
  final ApiService apiService;

  RepositoryBloc(this.apiService) : super(RepositoryInitial()) {
    on<FetchRepositories>(_onFetchRepositories);
  }

  Future<void> _onFetchRepositories(FetchRepositories event, Emitter<RepositoryState> emit) async {
    emit(RepositoryLoading());
    try {
      final repositories = await apiService.fetchRepositories(event.query, event.page, event.perPage);
      emit(RepositoryLoaded(repositories));
    } catch (e) {
      emit(RepositoryError(e.toString()));
    }
  }
}
