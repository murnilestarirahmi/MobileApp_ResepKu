class Recipe {
  final String name;
  final String images;
  final String category;
  final String totalTime;
  final List<String> ingredients;
  final List<String> steps;

  Recipe({
    required this.name,
    required this.images,
    required this.category,
    required this.totalTime,
    required this.ingredients,
    required this.steps,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'],
      images: json['images'],
      category: json['category'],
      totalTime: json['totalTime'],
      ingredients: List<String>.from(json['ingredients']),
      steps: List<String>.from(json['steps']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'images': images,
      'category': category,
      'totalTime': totalTime,
      'ingredients': ingredients,
      'steps': steps,
    };
  }

  @override
  String toString() {
    return 'Recipe {name: $name, image: $images, category: $category, totalTime: $totalTime, ingredients: $ingredients, steps: $steps}';
  }
}
