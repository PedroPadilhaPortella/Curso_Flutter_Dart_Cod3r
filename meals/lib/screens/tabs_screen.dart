import 'package:flutter/material.dart';
import 'package:meals/components/main_drawer.dart';
import 'package:meals/models/meal.dart';

import 'categories_screen.dart';
import 'favorite_screen.dart';
import 'meals.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  final List<Meal> allMeals;

  TabsScreen(this.favoriteMeals, this.allMeals);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedScreenIndex = 0;

  late final List<String> _titles;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _titles = [
      'Lista de Categorias',
      'Meus Favoritos',
      'Refeições',
    ];
    _screens = [
      CategoriesScreen(),
      FavoriteScreen(widget.favoriteMeals),
      Meals(meals: widget.allMeals),
    ];
  }

  _selectScreen(int i) {
    setState(() {
      _selectedScreenIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedScreenIndex]),
      ),
      body: _screens[_selectedScreenIndex],
      drawer: MainDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        backgroundColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        currentIndex: _selectedScreenIndex,
        // type: BottomNavigationBarType.shifting,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Categorias",
            // backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Favoritos",
            // backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_pizza),
            label: "Refeições",
            // backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
