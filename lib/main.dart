import 'package:flutter/material.dart';
import 'package:expenses/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: Theme.of(context).textTheme.copyWith(
              bodyText2: const TextStyle(
                color: Color(0xFFFFFFFF),
                fontFamily: 'Roboto',
              ),
              subtitle1: const TextStyle(
                color: Color(0xFFFFFFFF),
                fontFamily: 'Roboto',
                fontSize: 18,
              ),
              button: const TextStyle(
                color: Color(0xFFFFFFFF),
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
              ),
              caption: const TextStyle(
                color: Color(0xFF919191),
                fontFamily: 'Roboto',
              ),
            ),
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              titleTextStyle: const TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: const Color(0xFF64FFDA),
            onPrimary: const Color(0xFF616161),
            padding: const EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: const Color(0xFF64FFDA),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
