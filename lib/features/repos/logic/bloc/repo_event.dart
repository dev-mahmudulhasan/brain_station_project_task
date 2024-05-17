// lib/bloc/repository_event.dart
import 'package:equatable/equatable.dart';

abstract class RepositoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchRepositories extends RepositoryEvent {
  final String query;
  final int page;
  final int perPage;

  FetchRepositories(this.query, this.page, this.perPage);

  @override
  List<Object> get props => [query, page, perPage];
}
