import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_timer/ticker.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;
  static const int _duration = 70;

  StreamSubscription<int>? _tickerSubscription;

  //定義TimerBloc的初始狀態(super)
  //定義對Ticker的依賴關係
  TimerBloc({required Ticker ticker})
      : _ticker = ticker,
        super(const TimerInitial(_duration)) {
    //實現事件處裡 <event> (處理method)
    on<TimerStarted>(_onStarted);
    on<TimerPaused>(_onPaused);
    on<TimerResumed>(_onResumed);
    on<TimerReset>(_onReset);
    on<TimerTicked>(_onTicked);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
    emit(TimerRunInProgress(event.duration));
    _tickerSubscription?.cancel();
    _tickerSubscription =
        //監聽 _ticker.tick 流
        _ticker.tick(ticks: event.duration).listen((duration) {
      //在每個觸發時間，添加一個包含剩餘時間的TimerTicked事件
      add(TimerTicked(duration: duration));
    });
  }

  void _onPaused(TimerPaused event, Emitter<TimerState> emit) {
    if (state is TimerRunInProgress) {
      _tickerSubscription?.pause();
      emit(TimerRunPause(state.duration));
    }
  }

  void _onResumed(TimerResumed event, Emitter<TimerState> emit) {
    if (state is TimerRunPause) {
      _tickerSubscription?.resume();
      emit(TimerRunInProgress(state.duration));
    }
  }

  void _onReset(TimerReset event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    emit(const TimerInitial(_duration));
  }

  //每次收到TimerTicked事件:
  void _onTicked(TimerTicked event, Emitter<TimerState> emit) {
    emit(event.duration > 0
        ? TimerRunInProgress(event.duration) //發送一個帶有新的剩餘時間的狀態
        : const TimerRunComplete());
  }

  // @override
  // void onEvent(TimerEvent event) {
  //   super.onEvent(event);
  //   if (kDebugMode) {
  //     print(event);
  //   }
  // }

  // @override
  // void onChange(Change<TimerState> change) {
  //   super.onChange(change);
  //   if (kDebugMode) {
  //     print(change);
  //   }
  // }

  @override
  void onTransition(Transition<TimerEvent, TimerState> transition) {
    super.onTransition(transition);
    if (kDebugMode) {
      print(transition);
    }
  }
}
