// streak_screen.dart
import 'package:flutter/material.dart';

class StreakScreen extends StatelessWidget {
  const StreakScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final int currentStreak = 3;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Streak 🔥',
          style: TextStyle(color: theme.colorScheme.onBackground),
        ),
        backgroundColor: theme.colorScheme.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: theme.colorScheme.secondaryContainer,
              ),
              child: Row(
                children: [
                  const Icon(Icons.local_fire_department, size: 36, color: Colors.redAccent),
                  const SizedBox(width: 12),
                  Text(
                    '$currentStreak Day Streak',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSecondaryContainer,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Recent Activity (mock):',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(7, (index) {
                final isActive = index <= currentStreak - 1;
                return Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: isActive
                        ? theme.colorScheme.primary
                        : theme.colorScheme.surfaceVariant,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${index + 1}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isActive ? Colors.white : theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 32),
            Text(
              '💬 “Consistency compounds. Keep showing up.”',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onBackground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// streak_display.dart

// streak_display.dart

class StreakDisplay extends StatelessWidget {
  final int days;
  const StreakDisplay({super.key, required this.days});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: theme.colorScheme.secondaryContainer,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.local_fire_department, color: Colors.redAccent),
          Text(
            '🔥 $days day streak',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSecondaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
