part of 'timer_bloc.dart';

// TimerState
// We’ll start off by defining the TimerStates which our TimerBloc can be in.

// Our TimerBloc state can be one of the following:

// TimerInitial — ready to start counting down from the specified duration.
// TimerRunInProgress — actively counting down from the specified duration.
// TimerRunPause — paused at some remaining duration.
// TimerRunComplete — completed with a remaining duration of 0.
// Each of these states will have an implication on the user interface and actions that the user can perform. For example:

// if the state is TimerInitial the user will be able to start the timer.
// if the state is TimerRunInProgress the user will be able to pause and reset the timer as well as see the remaining duration.
// if the state is TimerRunPause the user will be able to resume the timer and reset the timer.
// if the state is TimerRunComplete the user will be able to reset the timer.
abstract class TimerState extends Equatable {
  final int duration;

  const TimerState(this.duration);

  @override
  List<Object> get props => [duration];
}

class TimerInitial extends TimerState {
  const TimerInitial(int duration) : super(duration);

  @override
  String toString() {
    return 'TimerInitial { duration: $duration }';
  }
}

class TimerRunPause extends TimerState {
  const TimerRunPause(int duration) : super(duration);

  @override
  String toString() {
    return 'TimerRunPause { duration: $duration }';
  }
}

class TimerRunInProgress extends TimerState {
  const TimerRunInProgress(int duration) : super(duration);

  @override
  String toString() {
    return 'TimerRunInProgress { duration: $duration }';
  }
}

class TimerRunComplete extends TimerState {
  const TimerRunComplete() : super(0);
}
