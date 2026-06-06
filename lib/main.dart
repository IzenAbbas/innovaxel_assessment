import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:innovaxel_assessment/features/auth/views/login.dart';
import 'package:provider/provider.dart';
import 'package:innovaxel_assessment/features/auth/view_models/auth_view_model.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Innovaxel Finance',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF000000),
        scaffoldBackgroundColor: const Color(0xFFF9F9FF),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF000000),
          onPrimary: Color(0xFFFFFFFF),
          surface: Color(0xFFF9F9FF),
          onSurface: Color(0xFF111C2D),
          error: Color(0xFFBA1A1A),
          onError: Color(0xFFFFFFFF),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFB7C4FF),
        scaffoldBackgroundColor: const Color(0xFF0B1326),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFB7C4FF),
          onPrimary: Color(0xFF002682),
          surface: Color(0xFF0B1326),
          onSurface: Color(0xFFDAE2FD),
          error: Color(0xFFFFB4AB),
          onError: Color(0xFF690005),
        ),
      ),
      themeMode: ThemeMode.system,
      home: const LoginScreen(),
    );
  }
}
