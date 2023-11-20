import 'package:flutter/material.dart';
import 'package:ipm_project/presentation/welcome_page.dart';
import 'package:ipm_project/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => Cart()),
    ], child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(builder: Builder(
      builder: (context) => MaterialApp(
        title: 'Interactive Museum',
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 196, 209, 214),  // This is the text color
              foregroundColor: Colors.black,  // This is the background color
            ),
          ),
        ),
        home: const WelcomePage(),
        debugShowCheckedModeBanner: false,
      )
    )
    );
  }
}

