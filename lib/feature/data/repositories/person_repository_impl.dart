import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';

import 'package:rick_and_morty/core/error/failure.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repositories/person_repository.dart';

class PersonRepositoryImpl implements PersonRepository {
  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query) {
    throw UnimplementedError();
  }
}
