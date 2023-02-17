import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'package:advisor_app/application/bloc/advisor_bloc.dart';
import 'package:advisor_app/domain/usecases/advisor_usecases.dart';
import 'package:advisor_app/domain/repositories/advisor_repository.dart';
import 'package:advisor_app/infrastructure/repositories/advisor_repository_impl.dart';
import 'package:advisor_app/infrastructure/datasources/advisor_remote_datasource.dart';

final sl = GetIt.I; // I = Instance, sl = service locator

Future<void> init() async {
  // Bloc registrieren mit factory contructor (jedes Mal ein neues Objekt!)
  // da der Bloc als Parameter "usecases" braucht, und diese sind (nachdem
  // die init function alle Instanzen registriert hat) im service locator
  // registriert, daher kann man einfach sl() übergeben
  // sprich: der sl (service locator) entscheidet selbst, was er als Parameter
  // mitgibt, und da hier der Parameter usecase vom Typ "AdvisorUseCase"
  // benötigt wird, findet er diesen unter den registrierten Instanzen

  sl.registerFactory(() => AdvisorBloc(usecases: sl()));

  // UseCases (singleton -> gibt jedes mal dasselbe Objekt zurück)
  // lazy heisst: während der Laufzeit, und auch nur, wenn eine Instanz
  // tatsächlich benötigt wird

  sl.registerLazySingleton(() => AdvisorUsecases(advisorRepository: sl()));

  // repos
  // hier ist folg. Besonderheit: Repositories haben eine abstrakte Klasse
  // und die Implementierung d.h. man muss dem Singleton sagen, dass er vom Typ
  // "AdvicerRepository" ist, sprich: wann immer ein Repository vom Typ
  // AdvicerRepository verlangt wird, soll die Implementierung (vom selben Typ)
  // ausgeliefert werden, also AdvicerRepositoryImpl

  sl.registerLazySingleton<AdvisorRepository>(
      () => AdvisorRepositoryImpl(advisorRemoteDatasource: sl()));

  // remote data sources
  // wie bei den repos (abstrakte klasse als Typ u. ausgeliefert wird die
  // Implementierung)
  // übergeben wird ein Client, bei dem man auch hier (in dieser Zeile) wieder
  // so tut, als sei er schon registriert (was er am Ende der init fn auch ist).
  // Das Entscheidene ist, dass der Client durch die DI nun modular ist, d.h.
  // später beim Testen gegen einen gemockten Client ausgetauscht werden kann
  // (da dieser gemockte Client keinen http request ausführen wird)

  sl.registerLazySingleton<AdvisorRemoteDatasource>(
      () => AdvisorRemoteDatasourceImpl(client: sl()));

  // extern
  // hier werden alle Klassen registriert, die man nicht selbst erstellt hat
  // und wie beim http package einfach via pubspec assist hinzufügt)

  sl.registerLazySingleton(() => http.Client());
}
