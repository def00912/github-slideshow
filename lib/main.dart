import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/code_execution_provider.dart';
import 'services/code_execution_service.dart';
import 'screens/code_editor_screen.dart';

void main() {
  runApp(const CodeInterpreterApp());
}

class CodeInterpreterApp extends StatelessWidget {
  const CodeInterpreterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CodeExecutionProvider(
            CodeExecutionService(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'AI Code Interpreter',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 0,
          ),
          cardTheme: CardTheme(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        home: const CodeEditorScreen(),
      ),
    );
  }
}
