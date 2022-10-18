import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/domain/usecases/search_person.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_state.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHED_FAILURE_MESSAGE = 'Cache Failure';

class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  final SearchPerson searchPerson;

  PersonSearchBloc({required this.searchPerson}) : super(PersonSearchEmpty()) {
    on<SearchPersons>(_onEvent);
  }

  FutureOr<void> _onEvent(
      SearchPersons event, Emitter<PersonSearchState> emit) async {
    var oldPerson = <PersonEntity>[];
    final currentState = state;

    if (currentState is PersonSearchLoaded) {
      oldPerson = currentState.persons;
    }

    emit(PersonSearchLoading(oldPerson, isFirstFetch: event.searchPage == 1));

    final failureOrPerson = await searchPerson(
        SearchPersonParams(query: event.personQuery, page: event.searchPage));
    failureOrPerson.fold(
        // метод fold (складывать) вовращает в L ошибку, а в R результат

        (failure) =>
            emit(PersonSearchError(message: _mapFailureToMessage(failure))),
        (person) {
      //final persons = (state as PersonSearchLoading).oldSearchPersonList;
      final persons = oldPerson;
      persons.addAll(person);
      //print(person.length);
      //print(persons.length);

      emit(PersonSearchLoaded(persons: persons));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHED_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
