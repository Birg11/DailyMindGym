// local_storage_service.dart
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _streakKey = 'current_streak';
  static const _lastWorkoutDateKey = 'last_workout_date';

  Future<int> getCurrentStreak() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_streakKey) ?? 0;
  }

  Future<void> setCurrentStreak(int streak) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_streakKey, streak);
  }

  Future<DateTime?> getLastWorkoutDate() async {
    final prefs = await SharedPreferences.getInstance();
    final dateStr = prefs.getString(_lastWorkoutDateKey);
    if (dateStr == null) return null;
    return DateTime.tryParse(dateStr);
  }

  Future<void> setLastWorkoutDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastWorkoutDateKey, date.toIso8601String());
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_streakKey);
    await prefs.remove(_lastWorkoutDateKey);
  }
}
