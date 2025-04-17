// local_storage_service_test.dart
import 'package:dailymindgym/services/local_storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late LocalStorageService storage;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    storage = LocalStorageService();
  });

  test('Default streak is 0', () async {
    final streak = await storage.getCurrentStreak();
    expect(streak, 0);
  });

  test('Can set and get current streak', () async {
    await storage.setCurrentStreak(5);
    final streak = await storage.getCurrentStreak();
    expect(streak, 5);
  });

  test('Can set and get last workout date', () async {
    final now = DateTime.now();
    await storage.setLastWorkoutDate(now);
    final retrieved = await storage.getLastWorkoutDate();
    expect(retrieved?.day, now.day);
  });

  test('Can clear all saved data', () async {
    await storage.setCurrentStreak(3);
    await storage.clearAll();
    final streak = await storage.getCurrentStreak();
    expect(streak, 0);
  });
}
