import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ToggleTheme extends ThemeEvent {}

// States
abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

class ThemeInitial extends ThemeState {
  final bool isDarkMode;

  const ThemeInitial({this.isDarkMode = false});

  @override
  List<Object> get props => [isDarkMode];

  ThemeInitial copyWith({bool? isDarkMode}) {
    return ThemeInitial(isDarkMode: isDarkMode ?? this.isDarkMode);
  }
}

// Bloc
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeInitial(isDarkMode: false)) {
    on<ToggleTheme>(_onToggleTheme);
  }

  void _onToggleTheme(ToggleTheme event, Emitter<ThemeState> emit) {
    print('=== THEME BLOC DEBUG ===');
    final currentState = state as ThemeInitial;
    print('Current theme: ${currentState.isDarkMode ? 'Dark' : 'Light'}');
    
    final newState = currentState.copyWith(isDarkMode: !currentState.isDarkMode);
    emit(newState);
    
    print('New theme: ${newState.isDarkMode ? 'Dark' : 'Light'}');
    print('=== END THEME BLOC DEBUG ===');
  }
} 