import 'package:flutter/material.dart';
import 'package:expenses/screens/home_page.dart';
import 'package:expenses/utils/db.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.instance.database;
  await Future.delayed(
    const Duration(
      seconds: 1,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(
          key: key,
        );

  Widget _childFunc(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF309B20),
        splashColor: const Color(0xFF13400C),
        scaffoldBackgroundColor: const Color(0xFF9E9E9E),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFF13400C),
          background: const Color(0xFFFFFFFF),
        ),
        appBarTheme: const AppBarTheme(
          color: Color(0xFF13400C),
          foregroundColor: Color(0xFFFFFFFF),
          iconTheme: IconThemeData(color: Color(0xFFFFFFFF)),
          titleTextStyle: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: const Color(0xFF13400C),
            onPrimary: const Color(0xFFFFFFFF),
            padding: const EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        cardTheme: const CardTheme(
          color: Color(0xFFCFCFCF),
          elevation: 6,
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 8,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: const Color(0xFF13400C),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          elevation: 6,
          backgroundColor: Color(0xFF13400C),
          foregroundColor: Color(0xFFFFFFFF),
        ),
        errorColor: const Color(0xFFC40000),
        textTheme: const TextTheme(
          bodyText2: TextStyle(
            color: Color(0xFF13400C),
            fontFamily: 'Roboto',
          ),
          subtitle1: TextStyle(
            color: Color(0xFF13400C),
            fontFamily: 'Roboto',
            fontSize: 18,
          ),
          button: TextStyle(
            color: Color(0xFF13400C),
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
          ),
          caption: TextStyle(
            color: Color(0xFF13400C),
            fontFamily: 'Roboto',
          ),
        ),
      ),
      home: const HomePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (BuildContext context, Widget? child) {
        final MediaQueryData mediaQuery = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQuery.copyWith(
            textScaleFactor: mediaQuery.textScaleFactor > 1.2
                ? 1.2
                : mediaQuery.textScaleFactor,
          ),
          child: _childFunc(context),
        );
      },
    );
  }
}
