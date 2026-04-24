import 'package:flutter/material.dart';
import 'package:freshcycle/features/cooking/presentation/cooking_session_screen.dart';
import 'package:freshcycle/features/cooking/presentation/cooking_summary_screen.dart';
import 'package:freshcycle/features/inventory/domain/models/inventory_item.dart';
import 'package:freshcycle/features/inventory/presentation/add/inventory_add_screen.dart';
import 'package:freshcycle/features/inventory/presentation/edit/inventory_edit_screen.dart';
import 'package:freshcycle/features/setting/presentation/main/setting_screen.dart';
import 'package:freshcycle/features/setting/presentation/password_security.dart/password_security_screen.dart';
import 'package:freshcycle/features/setting/presentation/profile_settings/profile_setting_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:freshcycle/core/layout/main_layout.dart';
import 'package:freshcycle/features/auth/presentation/login/main/login_screen.dart';
import 'package:freshcycle/features/auth/presentation/register/main/register_screen.dart';
import 'package:freshcycle/features/inventory/presentation/main/inventory_screen.dart';
import 'package:freshcycle/features/onboarding/presentation/main/onboarding_screen.dart';
import 'package:freshcycle/features/price_estimator/presentation/price_estimator_screen.dart';
import 'package:freshcycle/features/auth/presentation/profile_setup/profile_setup_screen.dart';
import 'package:freshcycle/features/recipe_ai/presentation/main/recipe_ai_screen.dart';
import 'package:freshcycle/features/recipe_ai/presentation/detail/recipe_detail_screen.dart';
import 'package:freshcycle/features/recipe_ai/domain/models/recipe_model.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/profile-setup',
  routes: [
    GoRoute(
      path: '/onboarding',
      builder: (context, _) => const OnboardingScreen(),
    ),
    GoRoute(path: '/login', builder: (context, _) => const LoginScreen()),
    GoRoute(path: '/register', builder: (context, _) => const RegisterScreen()),
    GoRoute(
      path: '/profile-setup',
      builder: (context, _) => const ProfileSetupScreen(),
    ),
    GoRoute(
      path: '/setting',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, _) => const SettingScreen(),
    ),
    GoRoute(
      path: '/inventory/edit',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final item = state.extra as InventoryItem;
        return InventoryEditScreen(item: item);
      },
    ),
    GoRoute(
      path: '/inventory/add',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, _) => const InventoryAddScreen(),
    ),
    GoRoute(
      path: '/setting/profile',
      builder: (context, _) => const ProfileSettingScreen(),
    ),
    GoRoute(
      path: '/setting/password-security',
      builder: (context, _) => const PasswordSecurityScreen(),
    ),
    GoRoute(
      path: '/recipe-ai/detail',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final recipe = state.extra as RecipeModel;
        return RecipeDetailScreen(recipe: recipe);
      },
    ),
    GoRoute(
      path: '/cooking-session',
      builder: (context, _) => const CookingSessionScreen(),
    ),
    GoRoute(
      path: '/cooking-summary',
      builder: (context, _) => const CookingSummaryScreen(
        recipeTitle: '',
        recipeEmoji: '',
        adjustedQty: {},
        steps: [],
      ),
    ),
    GoRoute(
      path: '/profile-setup',
      builder: (context, _) => const ProfileSetupScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainLayout(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/inventory',
              builder: (context, _) => const InventoryScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/recipe-ai',
              builder: (context, _) => const RecipeAiScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/price-estimator',
              builder: (context, _) => const PriceEstimatorScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
