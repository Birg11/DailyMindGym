// workout_player_screen.dart
import 'dart:async';
import 'package:dailymindgym/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkoutPlayerScreen extends StatefulWidget {
  const WorkoutPlayerScreen({super.key});

  @override
  State<WorkoutPlayerScreen> createState() => _WorkoutPlayerScreenState();
}

class _WorkoutPlayerScreenState extends State<WorkoutPlayerScreen> {
  int currentTask = 0;
  final storage = LocalStorageService();
  bool showDot = true;
  bool tapCompleted = false;
  bool moodSelected = false;
  String memoryAnswer = '';
  String selectedMood = '';
  final TextEditingController _controller = TextEditingController();

  final List<Map<String, dynamic>> tasks = [
    {
      'type': 'memory',
      'title': 'Memory Match',
      'sequence': [4, 9, 2, 7],
    },
    {
      'type': 'focus',
      'title': 'Focus Tap',
    },
    {
      'type': 'mood',
      'title': 'Mood Check-In',
    },
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> handleWorkoutCompletion() async {
    final today = DateTime.now();
    final lastDate = await storage.getLastWorkoutDate();
    int currentStreak = await storage.getCurrentStreak();

    if (lastDate != null) {
      final difference = today.difference(DateTime(lastDate.year, lastDate.month, lastDate.day)).inDays;
      if (difference == 0) {
        // same day
      } else if (difference == 1) {
        currentStreak++;
      } else {
        currentStreak = 1;
      }
    } else {
      currentStreak = 1;
    }

    await storage.setCurrentStreak(currentStreak);
    await storage.setLastWorkoutDate(today);

    if (selectedMood.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('last_mood', selectedMood);
    }
  }

  void nextTask() {
    setState(() {
      showDot = true;
      tapCompleted = false;
      moodSelected = false;
      memoryAnswer = '';
      _controller.clear();
    });

    if (currentTask < tasks.length - 1) {
      setState(() {
        currentTask++;
      });
    } else {
      handleWorkoutCompletion().then((_) async {
        final prefs = await SharedPreferences.getInstance();
        final streak = await storage.getCurrentStreak();
        final mood = prefs.getString('last_mood') ?? '😊';

        if (!mounted) return;
  context.go('/reward');

      });
    }
  }

  Widget _buildTaskWidget(Map<String, dynamic> task) {
    final theme = Theme.of(context);
    final type = task['type'];

    switch (type) {
      case 'memory':
        final sequence = task['sequence'].join(', ');
        return Column(
          children: [
            Text('Memorize this sequence: $sequence', style: theme.textTheme.titleLarge),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Type something to continue'),
              onChanged: (val) => setState(() => memoryAnswer = val),
            ),
          ],
        );

      case 'focus':
        return Center(
          child: showDot
              ? GestureDetector(
                  onTap: () => setState(() => tapCompleted = true),
                  child: const CircleAvatar(radius: 40, backgroundColor: Colors.blue),
                )
              : const Text('Loading...', style: TextStyle(fontSize: 20)),
        );

      case 'mood':
        return Column(
          children: [
            const Text('How are you feeling today?'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              children: [
                for (var emoji in ['😄', '😐', '😔', '😤'])
                  GestureDetector(
                    onTap: () => setState(() {
                      selectedMood = emoji;
                      moodSelected = true;
                    }),
                    child: Text(emoji, style: const TextStyle(fontSize: 32)),
                  ),
              ],
            )
          ],
        );

      default:
        return const Text('Unknown task');
    }
  }

  bool get isCurrentTaskComplete {
    final task = tasks[currentTask];
    switch (task['type']) {
      case 'memory':
        return memoryAnswer.trim().isNotEmpty;
      case 'focus':
        return tapCompleted;
      case 'mood':
        return moodSelected;
      default:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final task = tasks[currentTask];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          task['title']!,
          style: TextStyle(color: theme.colorScheme.onBackground),
        ),
        backgroundColor: theme.colorScheme.background,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onBackground),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTaskWidget(task),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: isCurrentTaskComplete ? nextTask : null,
              child: Text(currentTask < tasks.length - 1 ? 'Next' : 'Finish'),
            ),
          ],
        ),
      ),
    );
  }
}
