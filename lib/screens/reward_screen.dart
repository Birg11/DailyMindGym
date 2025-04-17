// reward_screen.dart
import 'package:dailymindgym/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({super.key});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  int streak = 0;
  String mood = '😊';

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final storage = LocalStorageService();
    final s = await storage.getCurrentStreak();
    setState(() {
      streak = s;
      mood = prefs.getString('last_mood') ?? '😊';
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('🎉 Workout Complete! 🎉',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Text('Your streak: $streak days', style: theme.textTheme.titleLarge),
              const SizedBox(height: 12),
              Text('Your mood: $mood', style: const TextStyle(fontSize: 32)),
              const SizedBox(height: 40),
              ElevatedButton(
onPressed: () => context.go('/'),
                child: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
