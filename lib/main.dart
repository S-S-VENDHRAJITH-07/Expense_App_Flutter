import 'package:flutter/material.dart';

import 'package:more_in_flutter/expenses.dart';

var kColorScheme=ColorScheme.fromSeed(seedColor:Color.fromARGB(255, 96, 59, 181) );
var kDarkScheme=ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 5, 99, 125),
  brightness: Brightness.dark,
  );
void main() {
  runApp(
    MaterialApp(
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(
        colorScheme: kDarkScheme,
        cardTheme: CardTheme(
            color: kDarkScheme.secondaryContainer,
            margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8)
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: kDarkScheme.primaryContainer,
                foregroundColor:kDarkScheme.onPrimaryContainer,
              )
              ),
      ),
      theme: ThemeData.from(
        colorScheme: kColorScheme,
        useMaterial3: true,
        ).copyWith(
          appBarTheme: AppBarTheme(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer
          ),
          cardTheme: CardTheme(
            color: kColorScheme.secondaryContainer,
            margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8)
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: kColorScheme.primaryContainer,
              )
              ),
              textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontSize: 16,
                  color: kColorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold
                )
              ),
          colorScheme: kColorScheme
           ,
           ),
          
home: SafeArea(child: Expenses()),
    ),
  );
}