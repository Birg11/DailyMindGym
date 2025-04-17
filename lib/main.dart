// main.dart
import 'package:dailymindgym/router/app_router.dart';
import 'package:dailymindgym/services/notification.dart';
import 'package:dailymindgym/services/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  runApp(const DailyMindGymApp());
}

class DailyMindGymApp extends StatelessWidget {
  const DailyMindGymApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeManager(),
      builder: (context, _) {
        final themeManager = Provider.of<ThemeManager>(context);

        final themeData = ThemeData(
          useMaterial3: true,
          textTheme: GoogleFonts.manropeTextTheme(),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigo,
            brightness: Brightness.light,
          ),
        );

        final darkThemeData = ThemeData(
          useMaterial3: true,
          textTheme: GoogleFonts.manropeTextTheme(),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigo,
            brightness: Brightness.dark,
          ),
        );

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Daily Mind Gym',
          themeMode: themeManager.themeMode,
          theme: themeData,
          darkTheme: darkThemeData,
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
