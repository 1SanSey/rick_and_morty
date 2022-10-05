import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/core/usecases/usecase.dart';
import 'package:rick_and_morty/feature/domain/repositories/person_repository.dart';

import '../../../core/error/failure.dart';
import '../entities/person_entity.dart';

class AllPersons extends UseCase<List<PersonEntity>, PagePersonParams> {
  final PersonRepository personRepository;

  AllPersons(this.personRepository);

  @override
  Future<Either<Failure, List<PersonEntity>>> call(
      PagePersonParams params) async {
    return await personRepository.getAllPersons(params.page);
  }
}

class PagePersonParams extends Equatable {
  final int page;

  PagePersonParams({required this.page});

  @override
  List<Object?> get props => [];
}
