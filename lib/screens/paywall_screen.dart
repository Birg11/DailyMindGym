// paywall_screen.dart
import 'package:flutter/material.dart';

class PaywallScreen extends StatelessWidget {
  const PaywallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Upgrade to Premium 💎',
          style: TextStyle(color: theme.colorScheme.onBackground),
        ),
        backgroundColor: theme.colorScheme.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Unlock Your Full Mind Gym 🧠💪',
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '✅ Full Workout Archive\n✅ Custom Workout Plans\n✅ Detailed Stats & Trends\n✅ Ad-free Experience',
              textAlign: TextAlign.left,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onBackground,
              ),
            ),
            const Spacer(),
            ElevatedButton.icon(
              icon: const Icon(Icons.workspace_premium),
              label: const Text('Upgrade Now'),
              onPressed: () {
                // TODO: handle purchase logic
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                // TODO: restore purchases
              },
              child: Text(
                'Restore Purchase',
                style: TextStyle(color: theme.colorScheme.primary),
              ),
            )
          ],
        ),
      ),
    );
  }
}
