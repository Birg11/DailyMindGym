// settings_screen.dart
import 'package:dailymindgym/services/notification.dart';
import 'package:dailymindgym/services/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool remindersEnabled = true;
  TimeOfDay reminderTime = const TimeOfDay(hour: 8, minute: 0);

  @override
  void initState() {
    super.initState();
    _loadReminderPrefs();
  }

  Future<void> _loadReminderPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      remindersEnabled = prefs.getBool('daily_reminder_enabled') ?? true;
      final hour = prefs.getInt('daily_reminder_hour') ?? 8;
      final minute = prefs.getInt('daily_reminder_minute') ?? 0;
      reminderTime = TimeOfDay(hour: hour, minute: minute);
    });
  }

  Future<void> _toggleReminder(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      remindersEnabled = value;
    });
    await prefs.setBool('daily_reminder_enabled', value);
    if (value) {
      await NotificationService.scheduleDailyReminder(
        hour: reminderTime.hour,
        minute: reminderTime.minute,
      );
    } else {
      await NotificationService.cancelReminder();
    }
  }

  Future<void> _pickReminderTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: reminderTime,
    );
    if (picked != null) {
      final prefs = await SharedPreferences.getInstance();
      setState(() => reminderTime = picked);
      await prefs.setInt('daily_reminder_hour', picked.hour);
      await prefs.setInt('daily_reminder_minute', picked.minute);
      if (remindersEnabled) {
        await NotificationService.scheduleDailyReminder(
          hour: picked.hour,
          minute: picked.minute,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final isDarkMode = themeManager.themeMode == ThemeMode.dark;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings ⚙️',
          style: TextStyle(color: theme.colorScheme.onBackground),
        ),
        backgroundColor: theme.colorScheme.background,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SwitchListTile(
            title: Text(
              'Dark Mode',
              style: TextStyle(color: theme.colorScheme.onBackground),
            ),
            secondary: Icon(Icons.dark_mode, color: theme.colorScheme.onBackground),
            value: isDarkMode,
            onChanged: (value) => themeManager.toggleTheme(value),
          ),
          const Divider(height: 32),
          SwitchListTile(
            title: Text(
              'Daily Reminders',
              style: TextStyle(color: theme.colorScheme.onBackground),
            ),
            secondary: Icon(Icons.notifications_active, color: theme.colorScheme.onBackground),
            value: remindersEnabled,
            onChanged: _toggleReminder,
          ),
          if (remindersEnabled)
            ListTile(
              leading: Icon(Icons.schedule, color: theme.colorScheme.onBackground),
              title: Text(
                'Remind me at: ${reminderTime.format(context)}',
                style: TextStyle(color: theme.colorScheme.onBackground),
              ),
              onTap: _pickReminderTime,
            ),
          const Divider(height: 32),
          ListTile(
            leading: Icon(Icons.info_outline, color: theme.colorScheme.onBackground),
            title: Text(
              'About',
              style: TextStyle(color: theme.colorScheme.onBackground),
            ),
            subtitle: Text(
              'Version 1.0.0 • Made with ❤️',
              style: TextStyle(color: theme.colorScheme.onBackground.withOpacity(0.7)),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
