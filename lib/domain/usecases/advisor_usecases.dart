import 'package:advisor_app/domain/entities/advice_entity.dart';
import 'package:advisor_app/domain/failures/failures.dart';
import 'package:advisor_app/domain/repositories/advisor_repository.dart';
import 'package:advisor_app/infrastructure/repositories/advisor_repository_impl.dart';
import 'package:dartz/dartz.dart';
// fürs functional programming wird das dartz package runtergeladen
// das ermöglicht es, entweder (either) einen failure oder
// eine AdviceEntity von der Function zurückzugeben
// um die rechte Seite zurückzugeben (also die AdviceEntity) wrappt man
// mit Right() und für die linke Seite (Failure) mit Left()

Future sleep1() {
  return Future.delayed(const Duration(seconds: 1), () => '1');
}

class AdvisorUsecases {
  final AdvisorRepository advisorRepository;

  AdvisorUsecases({required this.advisorRepository});

  Future<Either<Failure, AdviceEntity>> getAdviceUsecase() async {
    // 1. Aufruf einer Funktion des Repositories (um den Advice von der api zu requesten)
    return advisorRepository.getAdviceFromApi();

    // 2. hier könnte noch business logic implementiert werden
    // zB Rechnungen.. alles, was von der DB oder API kommt und
    // noch nachbearbeitet werden muss

    // Simulation des Requests
    // await sleep1();

    // Rückgabe von: entweder dem Advice oder einem Fehler
    // return Left(ServerFailure());
    // return Right(AdviceEntity(advice: "Iss niemals gelben Schnee", id: 1));
  }
}
