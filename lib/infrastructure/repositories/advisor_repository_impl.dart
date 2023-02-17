import 'package:advisor_app/domain/failures/failures.dart';
import 'package:advisor_app/domain/entities/advice_entity.dart';
import 'package:advisor_app/domain/repositories/advisor_repository.dart';
import 'package:advisor_app/infrastructure/datasources/advisor_remote_datasource.dart';
import 'package:advisor_app/infrastructure/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';

class AdvisorRepositoryImpl implements AdvisorRepository {
  final AdvisorRemoteDatasource advisorRemoteDatasource;

  AdvisorRepositoryImpl({required this.advisorRemoteDatasource});

  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromApi() async {
    try {
      final advice = await advisorRemoteDatasource.getRandomAdviceFromApi();
      return Right(advice);
    } catch (e) {
      if (e.runtimeType is ServerException) {
        return Left(ServerFailure());
      } else {
        return Left(GeneralFailure());
      }
    }
  }
}
