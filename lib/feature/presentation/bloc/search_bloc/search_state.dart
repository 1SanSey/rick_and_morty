import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';

abstract class PersonSearchState extends Equatable {
  const PersonSearchState();
  @override
  List<Object?> get props => [];
}

class PersonSearchEmpty extends PersonSearchState {}

class PersonSearchLoading extends PersonSearchState {
  final List<PersonEntity> oldSearchPersonList;
  final bool isFirstFetch;

  const PersonSearchLoading(this.oldSearchPersonList,
      {this.isFirstFetch = false});

  @override
  List<Object?> get props => [oldSearchPersonList];
}

class PersonSearchLoaded extends PersonSearchState {
  final List<PersonEntity> persons;
  // final int page;

  const PersonSearchLoaded({required this.persons});

  @override
  List<Object?> get props => [persons];
}

class PersonSearchError extends PersonSearchState {
  final String message;

  const PersonSearchError({required this.message});
  @override
  List<Object?> get props => [message];
}
