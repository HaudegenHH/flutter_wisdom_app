import 'package:advisor_app/application/bloc/advisor_bloc.dart';
import 'package:advisor_app/presentation/advisor/advisor_page.dart';
import 'package:advisor_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:advisor_app/injection.dart' as di;

// dem BlocProvider wird gesagt: schau im di-container nach und gib mittels
// service locator (sl) die Instanz vom Typ AdvisorBloc zurück

void main() async {
  // starte erst wenn alles initialisiert ist
  WidgetsFlutterBinding.ensureInitialized();
  // initialisierung des di-containers
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advisor App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => di.sl<AdvisorBloc>(),
        child: AdvisorPage(),
      ),
    );
  }
}
