import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'repositories/preferences_repository_impl.dart';
import 'blocs/preferences/preferences_bloc.dart';
import 'blocs/my_bloc_delegate.dart';
import 'app.dart';

void main() {
  BlocSupervisor.delegate = MyBlocDelegate();

  final preferencesRepository = PreferencesRepositoryImpl();
  final preferencesBloc =
      PreferencesBloc(preferencesRepository: preferencesRepository);

  preferencesBloc.state
      .firstWhere((state) => state is PreferencesLoaded)
      .then((_) => runApp(App(
            preferencesRepository: preferencesRepository,
            preferencesBloc: preferencesBloc,
          )));
  preferencesBloc.dispatch(LoadPreferences());
}
