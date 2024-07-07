import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:resepku/models/recipe.dart';
import 'package:resepku/views/widgets/recipe_card.dart';
import 'package:resepku/views/add_recipe.dart';
import 'package:resepku/views/about.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Recipe> _recipes = [];

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    final String? recipesString = prefs.getString('recipes');
    if (recipesString != null) {
      final List<dynamic> recipesJson = jsonDecode(recipesString);
      setState(() {
        _recipes = recipesJson.map((json) => Recipe.fromJson(json)).toList();
      });
    }
  }

  Future<void> _saveRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    final String recipesString =
        jsonEncode(_recipes.map((recipe) => recipe.toJson()).toList());
    await prefs.setString('recipes', recipesString);
  }

  void _addRecipe(Recipe newRecipe) {
    setState(() {
      _recipes.add(newRecipe);
    });
    _saveRecipes();
  }

  void _updateRecipe(Recipe updatedRecipe) {
    setState(() {
      int index =
          _recipes.indexWhere((recipe) => recipe.name == updatedRecipe.name);
      if (index != -1) {
        _recipes[index] = updatedRecipe;
      } else {
        index = _recipes
            .indexWhere((recipe) => recipe.images == updatedRecipe.images);
        if (index != -1) {
          _recipes[index] = updatedRecipe;
        }
      }
    });
    _saveRecipes();
  }

  void _deleteRecipe(Recipe recipe) {
    setState(() {
      _recipes.remove(recipe);
    });
    _saveRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.restaurant_menu),
            SizedBox(width: 10),
            Text('ResepKu'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutPage()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _recipes.length,
        itemBuilder: (context, index) {
          return RecipeCard(
            recipe: _recipes[index],
            onUpdate: _updateRecipe,
            onDelete: () => _deleteRecipe(_recipes[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddRecipePage(onSave: _addRecipe),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Buat Resep'),
      ),
    );
  }
}
