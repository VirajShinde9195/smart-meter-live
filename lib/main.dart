import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'screens/dashboard_screen.dart';
import 'screens/live_pf_screen.dart';
import 'screens/history_screen.dart';
import 'screens/high_usage_screen.dart';
import 'screens/suggestions_screen.dart';
import 'screens/prototype_screen.dart';
import 'screens/weekly_graph.dart';


import 'providers/live_reading_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Initialize Supabase
  await Supabase.initialize(
    url:
        'https://daomjbawryhkobgbhgeh.supabase.co', // 🔹 Replace this with your Supabase project URL
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRhb21qYmF3cnloa29iZ2JoZ2VoIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc1ODEzNjAyNiwiZXhwIjoyMDczNzEyMDI2fQ.LnfIHVCJmLeWiq6Te4GyuU2OkgW2AXDZltU4SUHmRKo', // 🔹 Replace this with your Supabase anon key
  );

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => LiveReadingProvider())],
      child: EnergyMonitorApp(),
    ),
  );
}

class EnergyMonitorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Energy Monitor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.deepPurpleAccent,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFF1E1E2C),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          elevation: 0,
        ),
      ),
      home: DashboardScreen(),
      routes: {
        '/live': (_) => LivePFScreen(),
        '/history': (_) => HistoryScreen(), // ✅ Added back safely
        '/high_usage': (_) => HighUsageScreen(),
        '/suggestions': (_) => SuggestionsScreen(),
        '/prototype': (_) => PrototypeScreen(),
         // ✅ Added Weekly Graph Route
        '/weekly_graph': (_) => WeeklyGraph(),
      },
    );
  }
}
