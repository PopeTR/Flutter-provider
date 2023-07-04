import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals_provider/providers/favourites_provider.dart';
import 'package:meals_provider/providers/filters_provider.dart';
import 'package:meals_provider/providers/meals_provider.dart';
import 'package:meals_provider/screens/tabs.dart';
import 'package:provider/provider.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  // IMPORTANT: if you want to use Riverpod you must wrap your App in ProviderScope.
  // You can wrap only certain parts of the application, but we want to use is across the whole app
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FavouriteMeals()),
        ChangeNotifierProvider(create: (context) => FiltersData()),
        ChangeNotifierProvider(create: (context) => MealsData()),
        ChangeNotifierProvider(create: (context) => FilteredMeals()),
      ],
      child: MaterialApp(
        theme: theme,
        home: const TabsScreen(),
      ),
    );
  }
}
