import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';

import '../models/models.dart';

part 'my_form_event.dart';
part 'my_form_state.dart';

class MyFormBloc extends Bloc<MyFormEvent, MyFormState> {
  MyFormBloc() : super(const MyFormState()) {
    on<EmailChanged>(_onEmailChanged);
    on<EmailUnfocused>(_onEmailUnfocused);
    on<PasswordChanged>(_onPasswordChanged);
    on<PasswordUnfocused>(_onPasswordUnfocused);
    on<FormSubmitted>(_onFormSubmitted);
  }

  @override
  void onTransition(Transition<MyFormEvent, MyFormState> transition) {
    if (kDebugMode) {
      print(transition);
    }
    super.onTransition(transition);
  }

  void _onEmailChanged(EmailChanged event, Emitter<MyFormState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
      email: email.valid ? email : Email.pure(event.email),
      status: Formz.validate([email, state.password]),
    ));
  }

  void _onEmailUnfocused(EmailUnfocused event, Emitter<MyFormState> emit) {
    final email = Email.dirty(state.email.value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email, state.password]),
    ));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<MyFormState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password.valid ? password : Password.pure(event.password),
      status: Formz.validate([state.email, password]),
    ));
  }

  void _onPasswordUnfocused(
      PasswordUnfocused event, Emitter<MyFormState> emit) {
    final password = Password.dirty(state.password.value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([state.email, password]),
    ));
  }

  void _onFormSubmitted(FormSubmitted event, Emitter<MyFormState> emit) async {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    emit(state.copyWith(
      email: email,
      password: password,
      status: Formz.validate([email, password]),
    ));
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      await Future<void>.delayed(const Duration(seconds: 3));
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    }
  }
}
