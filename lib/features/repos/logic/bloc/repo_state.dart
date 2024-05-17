// lib/bloc/repository_state.dart
import 'package:equatable/equatable.dart';
 
import '../../data/repodata_model.dart';

abstract class RepositoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class RepositoryInitial extends RepositoryState {}

class RepositoryLoading extends RepositoryState {}

class RepositoryLoaded extends RepositoryState {
  final List<Repository> repositories;

  RepositoryLoaded(this.repositories);

  @override
  List<Object> get props => [repositories];
}

class RepositoryError extends RepositoryState {
  final String message;

  RepositoryError(this.message);

  @override
  List<Object> get props => [message];
}
