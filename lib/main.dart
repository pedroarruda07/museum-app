import 'package:flutter/material.dart';
import 'package:ipm_project/presentation/welcome_page.dart';
import 'package:showcaseview/showcaseview.dart';

void main() {
  runApp(const MyApp());
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
        //home: DiscoverPage()), //for faster debug of discover
        debugShowCheckedModeBanner: false,
      )
    )
    );
  }
}

