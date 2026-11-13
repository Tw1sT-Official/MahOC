import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/roster_screen.dart';
import 'services/character_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Dark immersive system overlay
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF09090D),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // Initialize offline storage
  await CharacterStorage.init();

  runApp(const MahOCApp());
}

class MahOCApp extends StatelessWidget {
  const MahOCApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mah OC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF09090D),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0F0F16),
          elevation: 0,
        ),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00E5FF),
          secondary: Color(0xFF7C4DFF),
          surface: Color(0xFF13131C),
        ),
      ),
      home: const RosterScreen(),
    );
  }
}
