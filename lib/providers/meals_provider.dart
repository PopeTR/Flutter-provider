import 'package:flutter/foundation.dart';
import 'package:meals_provider/data/dummy_data.dart';
import '../models/meal.dart';

class MealsData extends ChangeNotifier {
  final List<Meal> meals = dummyMeals;
  @override
  notifyListeners();
}
