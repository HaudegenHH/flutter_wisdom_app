part of 'advisor_bloc.dart';

abstract class AdvisorState {}

class AdviceInitial extends AdvisorState {}

class AdviceLoading extends AdvisorState {}

class AdviceLoaded extends AdvisorState {
  final String advice;
  AdviceLoaded({required this.advice});
}

class AdviceError extends AdvisorState {
  final String message;
  AdviceError({required this.message});
}
