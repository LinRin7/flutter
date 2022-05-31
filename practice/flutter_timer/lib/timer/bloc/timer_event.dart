part of 'timer_bloc.dart';

// TimerEvent
// Our TimerBloc will need to know how to process the following events:

// TimerStarted — informs the TimerBloc that the timer should be started.
// TimerPaused — informs the TimerBloc that the timer should be paused.
// TimerResumed — informs the TimerBloc that the timer should be resumed.
// TimerReset — informs the TimerBloc that the timer should be reset to the original state.
// TimerTicked — informs the TimerBloc that a tick has occurred and that it needs to update its state accordingly.
abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class TimerStarted extends TimerEvent {
  const TimerStarted({required this.duration});
  final int duration;
}

class TimerPaused extends TimerEvent {
  const TimerPaused();
}

class TimerResumed extends TimerEvent {
  const TimerResumed();
}

class TimerReset extends TimerEvent {
  const TimerReset();
}

//通知bloc，(每)一秒經過的事件發生
class TimerTicked extends TimerEvent {
  const TimerTicked({required this.duration});
  final int duration;

  @override
  List<Object> get props => [duration];
}
