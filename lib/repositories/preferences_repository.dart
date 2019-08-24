import '../models/theme.dart';

abstract class PreferencesRepository {
  Future<void> setTheme(Theme theme);

  Future<Theme> getTheme();
}
