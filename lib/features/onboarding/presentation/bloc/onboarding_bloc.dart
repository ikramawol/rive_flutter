import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object> get props => [];
}

class UpdateName extends OnboardingEvent {
  final String name;

  const UpdateName(this.name);

  @override
  List<Object> get props => [name];
}

class UpdateGoal extends OnboardingEvent {
  final String goal;

  const UpdateGoal(this.goal);

  @override
  List<Object> get props => [goal];
}

class UpdateInterests extends OnboardingEvent {
  final List<String> interests;

  const UpdateInterests(this.interests);

  @override
  List<Object> get props => [interests];
}

class SubmitProfile extends OnboardingEvent {}

// States
abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

class OnboardingInitial extends OnboardingState {}

class OnboardingInProgress extends OnboardingState {
  final String name;
  final String goal;
  final List<String> interests;

  const OnboardingInProgress({
    this.name = '',
    this.goal = '',
    this.interests = const [],
  });

  @override
  List<Object> get props => [name, goal, interests];

  OnboardingInProgress copyWith({
    String? name,
    String? goal,
    List<String>? interests,
  }) {
    return OnboardingInProgress(
      name: name ?? this.name,
      goal: goal ?? this.goal,
      interests: interests ?? this.interests,
    );
  }
}

class OnboardingSuccess extends OnboardingState {}

class OnboardingError extends OnboardingState {
  final String message;

  const OnboardingError(this.message);

  @override
  List<Object> get props => [message];
}

// Bloc
class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(const OnboardingInProgress()) {
    on<UpdateName>(_onUpdateName);
    on<UpdateGoal>(_onUpdateGoal);
    on<UpdateInterests>(_onUpdateInterests);
    on<SubmitProfile>(_onSubmitProfile);
  }

  void _onUpdateName(UpdateName event, Emitter<OnboardingState> emit) {
    if (state is OnboardingInProgress) {
      final currentState = state as OnboardingInProgress;
      emit(currentState.copyWith(name: event.name));
    }
  }

  void _onUpdateGoal(UpdateGoal event, Emitter<OnboardingState> emit) {
    if (state is OnboardingInProgress) {
      final currentState = state as OnboardingInProgress;
      emit(currentState.copyWith(goal: event.goal));
    }
  }

  void _onUpdateInterests(UpdateInterests event, Emitter<OnboardingState> emit) {
    if (state is OnboardingInProgress) {
      final currentState = state as OnboardingInProgress;
      emit(currentState.copyWith(interests: event.interests));
    }
  }

  Future<void> _onSubmitProfile(SubmitProfile event, Emitter<OnboardingState> emit) async {
    if (state is OnboardingInProgress) {
      final currentState = state as OnboardingInProgress;
      
      // Validate inputs
      if (currentState.name.isEmpty || currentState.goal.isEmpty || currentState.interests.isEmpty) {
        emit(const OnboardingError('Please fill in all fields'));
        return;
      }

      try {
        // Simulate API call
        await Future.delayed(const Duration(seconds: 1));
        emit(OnboardingSuccess());
      } catch (e) {
        emit(const OnboardingError('Failed to submit profile'));
      }
    }
  }
} 