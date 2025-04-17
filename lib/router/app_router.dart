// app_router.dart
import 'package:dailymindgym/screens/home_screen.dart';
import 'package:dailymindgym/screens/paywall_screen.dart';
import 'package:dailymindgym/screens/reward_screen.dart';
import 'package:dailymindgym/screens/settings_screen.dart';
import 'package:dailymindgym/screens/splash_screen.dart';
import 'package:dailymindgym/screens/streak_screen.dart';
import 'package:dailymindgym/screens/workout_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
GoRoute(
  path: '/',
  builder: (context, state) => const AnimatedSplashScreen(),
),
GoRoute(
  path: '/home',
  builder: (context, state) => const HomeScreen(),
),

      GoRoute(
        path: '/workout',
        builder: (context, state) => const WorkoutPlayerScreen(),
      ),
      GoRoute(
        path: '/streak',
        builder: (context, state) => const StreakScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/paywall',
        builder: (context, state) => const PaywallScreen(),
      ),
      GoRoute(
  path: '/reward',
  builder: (context, state) => const RewardScreen(),
),

    ],
  );
}