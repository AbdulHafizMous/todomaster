import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todolist/pages/liste.dart';
import 'package:todolist/pages/login.dart';

const supabaseUrl = 'https://nitlrmzkefgmjtyrjicc.supabase.co';
const supabaseKey = String.fromEnvironment('SUPABASE_KEY', defaultValue: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5pdGxybXprZWZnbWp0eXJqaWNjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDIwMjA5MzQsImV4cCI6MjA1NzU5NjkzNH0.2IBAqF0ZpLbR-v_AXTxCOw5FpOvqdmQyNG8iMolP-rk");

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
 
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: 
      Supabase.instance.client.auth.currentUser == null
                  ? LoginPage()
                  :
                   ListePage(),
    );
  }
}
