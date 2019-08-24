import 'package:flutter/material.dart';
import 'counter_screen.dart';
import 'blocs/counter_bloc.dart';
import 'blocs/stopwatch/stopwatch_bloc.dart';
import 'stopwatch_screen.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme_selector_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  void _pushScreen(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    final stopwatchBloc = BlocProvider.of<StopwatchBloc>(context);

    final chipColorShade =
        Theme.of(context).brightness == Brightness.light ? 300 : 800;

    return MultiBlocListener(
      listeners: [
        BlocListener<CounterBloc, int>(
          listener: (context, state) {
            if (state == 10) {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  content: Text('Count: $state'),
                ),
              );
            }
          },
        ),
        BlocListener<StopwatchBloc, StopwatchState>(
          listener: (context, state) {
            if (state.time.inMilliseconds == 10000) {
              if (!Navigator.of(context).canPop()) {
                _pushScreen(context, StopwatchScreenWithGlobalState());
              }
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('BLoC example'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.palette),
              onPressed: () => _pushScreen(context, ThemeSelectorScreen()),
            )
          ],
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text('Counter'),
              trailing: Chip(
                label: Text('Local State'),
                backgroundColor: Colors.blue[chipColorShade],
              ),
              onTap: () => _pushScreen(context, CounterScreenWithLocalState()),
            ),
            ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text('Counter'),
              subtitle: BlocBuilder<CounterBloc, int>(
                builder: (context, state) {
                  return Text('$state');
                },
              ),
              trailing: Chip(
                label: Text('Global State'),
                backgroundColor: Colors.green[chipColorShade],
              ),
              onTap: () => _pushScreen(context, CounterScreenWithGlobalState()),
              onLongPress: () {
                counterBloc.dispatch(CounterEvent.increment);
              },
            ),
            ListTile(
              leading: Icon(Icons.timer),
              title: Text('Stopwatch'),
              trailing: Chip(
                label: Text('Local State'),
                backgroundColor: Colors.blue[chipColorShade],
              ),
              onTap: () =>
                  _pushScreen(context, StopwatchScreenWithLocalState()),
            ),
            ListTile(
              leading: Icon(Icons.timer),
              title: Text('Stopwatch'),
              subtitle: BlocBuilder<StopwatchBloc, StopwatchState>(
                builder: (context, state) {
                  return Text('${state.timeFormated}');
                },
              ),
              trailing: Chip(
                label: Text('Global State'),
                backgroundColor: Colors.green[chipColorShade],
              ),
              onTap: () =>
                  _pushScreen(context, StopwatchScreenWithGlobalState()),
              onLongPress: () {
                if (stopwatchBloc.currentState.isRunning) {
                  stopwatchBloc.dispatch(StopStopwatch());
                } else {
                  stopwatchBloc.dispatch(StartStopwatch());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
