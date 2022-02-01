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
      // theme: ThemeData(
      //   primarySwatch: Colors.blueGrey,
      //   appBarTheme: const AppBarTheme(
      //     color: Color(0xFF125E75),
      //   ),
      //   colorScheme: ColorScheme.fromSwatch().copyWith(
      //     secondary: const Color(0xFF125E75),
      //   ),
      // ),
      theme: ThemeData.dark().copyWith(
        textTheme: ThemeData.dark().textTheme.apply(
              fontFamily: 'Quicksand',
            ),
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              titleTextStyle: const TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
      ),
      home: const HomePage(),
    );
  }
}
