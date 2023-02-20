part of 'base_cubit.dart';

abstract class BaseState extends Equatable {
  const BaseState();
  @override
  List<Object?> get props => [];
}

class LoadingState extends BaseState {
  const LoadingState();
}

class InitialState extends BaseState {
  const InitialState();
}

class SuccessState extends BaseState {
  const SuccessState();
}

class FailureState extends BaseState {
  final Failure failure;

  const FailureState(this.failure);

  @override
  List<Object?> get props => [failure];
}
