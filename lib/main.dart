import 'package:flutter/material.dart';
import 'package:flutter_ar_flutter_plugin_study/ui/ar_screen.dart';
import 'package:flutter_ar_flutter_plugin_study/ui/view/ar_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => ARViewModel())],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: ARScreen(),
      ),
    );
  }
}
