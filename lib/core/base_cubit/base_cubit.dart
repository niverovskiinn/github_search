import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:github_search/core/errors/failure.dart';

part 'base_states.dart';

abstract class BaseCubit extends Cubit<BaseState> {
  BaseCubit([BaseState state = const InitialState()]) : super(state);
}
