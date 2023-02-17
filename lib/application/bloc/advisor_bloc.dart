import 'package:advisor_app/domain/entities/advice_entity.dart';
import 'package:advisor_app/domain/failures/failures.dart';
import 'package:advisor_app/domain/usecases/advisor_usecases.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

part 'advisor_event.dart';
part 'advisor_state.dart';

const GENERAL_FAILURE_MESSAGE = "Oops, something went wrong. Please try again!";
const SERVER_FAILURE_MESSAGE = "Oops, API Error. please try again!";

class AdvisorBloc extends Bloc<AdvisorEvent, AdvisorState> {
  final AdvisorUsecases usecases;

  AdvisorBloc({required this.usecases}) : super(AdviceInitial()) {
    on<AdviceRequestedEvent>((event, emit) async {
      emit(AdviceLoading());

      Either<Failure, AdviceEntity> failureOrAdvice =
          await usecases.getAdviceUsecase();

      failureOrAdvice.fold(
        (failure) => emit(AdviceError(message: _mapFailureToMessage(failure))),
        (adviceEntity) => emit(AdviceLoaded(advice: adviceEntity.advice)),
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case GeneralFailure:
        return GENERAL_FAILURE_MESSAGE;

      default:
        return GENERAL_FAILURE_MESSAGE;
    }
  }
}



/*

--  der alte Weg um events zum state zu mappen mittels streams & yield ---

class AdvisorBloc extends Bloc<AdvisorEvent, AdvisorState> {
  AdvisorBloc() : super(AdviceInitial());

  Future sleep1() {
    return Future.delayed(const Duration(seconds: 1), () => '1');
  }

  @override
  Stream<AdvisorState> mapEventToState(
    AdvisorEvent event,
  ) async* {
    if (event is AdviceRequestedEvent) {

      -- yielding loading state
      yield AdviceLoading();

      -- sleep1();
      -- yield AdviceLoaded(advice: "advice");
      
      Either<Failure, AdviceEntity> failureOrAdvice =
          await usecases.getAdviceUsecase();

      -- after executing the fn from the domain layer you will get 
      -- either a failure or an advice object
      -- so that either an error state or a loaded state will be emitted

      yield failureOrAdvice.fold(
          (failure) => AdviceError(message: _mapFailureToMessage(failure)),
          (adviceEntity) => AdviceLoaded(advice: adviceEntity.advice)
      );

    }
  }
}
*/