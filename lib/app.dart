import 'package:flutter/material.dart' hide Theme;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'repositories/preferences_repository.dart';
import 'blocs/preferences/preferences_bloc.dart';
import 'blocs/stopwatch/stopwatch_bloc.dart';
import 'blocs/counter_bloc.dart';
import 'models/theme.dart';
import 'themes_data.dart';
import 'home_screen.dart';

class App extends StatelessWidget {
  final PreferencesRepository preferencesRepository;
  final PreferencesBloc preferencesBloc;

  const App(
      {Key key,
      @required this.preferencesRepository,
      @required this.preferencesBloc})
      : assert(preferencesRepository != null),
        assert(preferencesBloc != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<PreferencesRepository>.value(
          value: preferencesRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<PreferencesBloc>.value(value: preferencesBloc),
          BlocProvider<CounterBloc>(builder: (context) => CounterBloc()),
          BlocProvider<StopwatchBloc>(builder: (context) => StopwatchBloc()),
        ],
        child: BlocBuilder<PreferencesBloc, PreferencesState>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: state is PreferencesLoaded
                  ? themesData[state.theme]
                  : themesData[Theme.dark],
              home: HomeScreen(),
            );
          },
        ),
      ),
    );
  }
}
