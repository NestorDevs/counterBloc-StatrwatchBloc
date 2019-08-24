import 'package:equatable/equatable.dart';
import '../../models/theme.dart';

abstract class PreferencesEvent extends Equatable {
  PreferencesEvent([List props = const []]) : super(props);
}

class LoadPreferences extends PreferencesEvent {}

class UpdateTheme extends PreferencesEvent {
  final Theme theme;

  UpdateTheme(this.theme) : super([theme]);

  @override
  String toString() => 'runtimeType { $theme }';
}
