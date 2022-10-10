import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/error/failure.dart';

abstract class UseCase<Type, Params> {
  // Type тип возврата без ошибок, PersonEntity
  // Params вызовет незначительные изменения кода в существующих UseCases
  Future<Either<Failure, Type>> call(Params params);
}
