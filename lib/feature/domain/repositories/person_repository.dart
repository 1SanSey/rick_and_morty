import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';

import '../../../core/error/failure.dart';

// репозиторий - интерфейс-адаптер, который преобразует данные из db или API
// в формат удобный для usecases и entities

abstract class PersonRepository {
  // абстрактный класс определяет контракт, а реализация его будет в уровне Data
  // тип Either может возвращать и ошибки (Left), и список персонажей(Right) одновременно
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(
      int page); // подгрузка персонажей и пагинация
  Future<Either<Failure, List<PersonEntity>>> searchPerson(
      String query, int page);
}
