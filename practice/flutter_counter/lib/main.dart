import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter/app.dart';
import 'package:flutter_counter/counter_observer.dart';

// 核心要點
// Observe state changes with BlocObserver.
// BlocProvider, Flutter widget which provides a bloc to its children.
// BlocBuilder, Flutter widget that handles building the widget in response to new states.
// Using Cubit instead of Bloc. What's the difference?
// Adding events with context.read.⚡

void main() {
  BlocOverrides.runZoned(
    () => runApp(const CounterApp()),
    blocObserver: CounterObserver(),
  );
}
