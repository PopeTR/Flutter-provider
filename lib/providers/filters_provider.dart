import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meals_provider/models/meal.dart';
import 'package:meals_provider/providers/meals_provider.dart';
import 'package:provider/provider.dart';

// Moving enum Filter here as this is where the all the meta management of filters and all the type definitions for filters basically happen.
enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersData extends ChangeNotifier {
  // super takes the initial state. So for filters provider, we need to have the state as all false
  Map<Filter, bool> _filters = {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegan: false,
    Filter.vegetarian: false,
  };

// This puts a strict version so you cant call .add or update the original list
  UnmodifiableMapView<Filter, bool> get filters {
    return UnmodifiableMapView(_filters);
  }

  void setFilters(Map<Filter, bool> chosenFilters) {
    _filters = chosenFilters;
    notifyListeners();
  }

  void setFilter(Filter filter, bool isActive) {
    // Here we are creating a NEW Map, by copying all values across and updating the one in question to the required value.
    _filters = {
      ...filters,
      filter: isActive,
    };
    notifyListeners();
  }
}

class FilteredMeals extends ChangeNotifier {
  List<Meal> getFilteredMeals(BuildContext context) {
    final meals = Provider.of<MealsData>(context).meals;
    final activeFilters = Provider.of<FiltersData>(context).filters;

    return meals.where((meal) {
      return _filterMeal(meal, activeFilters);
    }).toList();
  }

  bool _filterMeal(Meal meal, Map<Filter, bool> activeFilters) {
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }
}
