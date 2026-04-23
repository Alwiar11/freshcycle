import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/network/supabase_config.dart';
import 'package:freshcycle/core/router/app_router.dart';
import 'package:freshcycle/core/theme/app_theme.dart';
import 'package:freshcycle/core/theme/app_theme_notifier.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return ValueListenableBuilder<ThemeMode>(
          valueListenable: AppThemeNotifier.instance,
          builder: (context, themeMode, _) {
            return MaterialApp.router(
              routerConfig: appRouter,
              title: 'FreshCycle',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme, // ← tambahkan dark theme
              themeMode: themeMode,
            );
          },
        );
      },
    );
  }
}
