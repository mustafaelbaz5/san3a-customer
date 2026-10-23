import 'package:flutter/material.dart';
import 'core/routes/app_router.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const San3aApp());
}

class San3aApp extends StatelessWidget {
  const San3aApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'San3a',
      theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
    );
  }
}
