import 'package:flutter/material.dart';
import 'action_button.dart';
import 'blocs/stopwatch/stopwatch_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class StopwatchScreenWithLocalState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) => StopwatchBloc(),
      child: StopwatchScaffold(
        title: 'Stopwatch = Local State',
      ),
    );
  }
}

class StopwatchScreenWithGlobalState extends StatelessWidget {
  const StopwatchScreenWithGlobalState({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StopwatchScaffold(
      title: 'Stopwatch - Global State',
    );
  }
}

class StopwatchScaffold extends StatelessWidget {
  final String title;
  const StopwatchScaffold({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stopwatchBloc = BlocProvider.of<StopwatchBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocListener<StopwatchBloc, StopwatchState>(
        listener: (context, state) {
          if (state.isSpecial) {
            Scaffold.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.lightGreenAccent,
              content: Text(
                '${state.timeFormated}',
                style: TextStyle(color: Colors.black87),
              ),
              duration: Duration(seconds: 1),
            ));
          }
        },
        child: Center(
          child: BlocBuilder<StopwatchBloc, StopwatchState>(
            builder: (context, state) {
              return Text(state.timeFormated,
                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold));
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(16.0),
        child: BlocBuilder<StopwatchBloc, StopwatchState>(
          condition: (previousState, currentState) {
            return previousState.isInitial != currentState.isInitial ||
                previousState.isRunning != currentState.isRunning;
          },
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                if (state.isRunning)
                  ActionButton(
                    iconData: Icons.stop,
                    onPressed: () {
                      stopwatchBloc.dispatch(StopStopwatch());
                    },
                  )
                else
                  ActionButton(
                    iconData: Icons.play_arrow,
                    onPressed: () {
                      stopwatchBloc.dispatch(StartStopwatch());
                    },
                  ),
                if (!state.isInitial)
                  ActionButton(
                    iconData: Icons.replay,
                    onPressed: () {
                      stopwatchBloc.dispatch(ResetStopwatch());
                    },
                  )
              ],
            );
          },
        ),
      ),
    );
  }
}
