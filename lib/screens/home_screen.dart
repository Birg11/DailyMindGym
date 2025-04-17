// home_screen.dart
import 'package:dailymindgym/screens/streak_screen.dart';
import 'package:dailymindgym/services/local_storage_service.dart';
import 'package:dailymindgym/widgets/workout_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int streak = 0;
  final storage = LocalStorageService();

  @override
  void initState() {
    super.initState();
    loadStreak();
  }

  Future<void> loadStreak() async {
    final current = await storage.getCurrentStreak();
    setState(() => streak = current);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daily Mind Gym 🧠',
          style: TextStyle(color: theme.colorScheme.onBackground),
        ),
        backgroundColor: theme.colorScheme.background,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: theme.colorScheme.onBackground),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Today's Workout",
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 16),
            WorkoutPreviewCard(
              title: 'Focus Sprint 🧘',
              description: 'Quick challenge to sharpen your focus in 5 minutes.',
              onTap: () async {
                await context.push('/workout');
                await loadStreak();
              },
            ),
            const SizedBox(height: 24),
            Text(
              "Your Streak",
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 12),
            StreakDisplay(days: streak),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) context.push('/streak');
          if (index == 2) context.push('/paywall');
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.local_fire_department), label: 'Streak'),
          BottomNavigationBarItem(icon: Icon(Icons.workspace_premium), label: 'Premium'),
        ],
      ),
    );
  }
}
