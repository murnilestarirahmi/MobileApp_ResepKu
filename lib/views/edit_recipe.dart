import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resepku/models/recipe.dart';

class EditRecipePage extends StatefulWidget {
  final Recipe recipe;
  final Function(Recipe) onSave;

  const EditRecipePage({super.key, required this.recipe, required this.onSave});

  @override
  _EditRecipePageState createState() => _EditRecipePageState();
}

class _EditRecipePageState extends State<EditRecipePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _timeController;
  late String _category;
  late List<String> _ingredients;
  late List<String> _steps;
  late String _imageUrl;
  final ImagePicker _picker = ImagePicker();

  final List<String> _categories = [
    'Makanan Berat',
    'Makanan Ringan',
    'Minuman'
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.recipe.name);
    _timeController = TextEditingController(
        text: widget.recipe.totalTime.replaceAll(' menit', ''));
    _category = _categories.contains(widget.recipe.category)
        ? widget.recipe.category
        : _categories[0];
    _ingredients = List.from(widget.recipe.ingredients);
    _steps = List.from(widget.recipe.steps);
    _imageUrl = widget.recipe.images;
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageUrl = pickedFile.path;
      });
    }
  }

  void _addIngredient() {
    setState(() {
      _ingredients.add('');
    });
  }

  void _addStep() {
    setState(() {
      _steps.add('');
    });
  }

  void _removeIngredient(int index) {
    setState(() {
      _ingredients.removeAt(index);
    });
  }

  void _removeStep(int index) {
    setState(() {
      _steps.removeAt(index);
    });
  }

  void _saveRecipe() {
    if (_formKey.currentState!.validate()) {
      final updatedRecipe = Recipe(
        name: _nameController.text,
        images: _imageUrl,
        category: _category,
        totalTime: '${_timeController.text} menit',
        ingredients: _ingredients,
        steps: _steps,
      );
      widget.onSave(updatedRecipe);
      Navigator.pop(context, updatedRecipe);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Resep ${widget.recipe.name}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama Resep'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama resep tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Ubah Gambar'),
                ),
              ),
              if (_imageUrl.isNotEmpty)
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Image.file(File(_imageUrl)),
                        ),
                      );
                    },
                    child: const Text('Tinjau Gambar'),
                  ),
                ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _category,
                decoration: const InputDecoration(labelText: 'Kategori'),
                items: _categories
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _category = value!;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _timeController,
                decoration:
                    const InputDecoration(labelText: 'Waktu Pembuatan (menit)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Waktu tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Bahan-Bahan',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              ..._ingredients.asMap().entries.map((entry) {
                int index = entry.key;
                String ingredient = entry.value;
                return Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: ingredient,
                        onChanged: (value) {
                          _ingredients[index] = value;
                        },
                        decoration:
                            InputDecoration(labelText: 'Bahan ${index + 1}'),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _removeIngredient(index),
                    ),
                  ],
                );
              }),
              Center(
                child: TextButton(
                  onPressed: _addIngredient,
                  child: const Text('Tambah Bahan'),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Langkah Pembuatan',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              ..._steps.asMap().entries.map((entry) {
                int index = entry.key;
                String step = entry.value;
                return Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: step,
                        onChanged: (value) {
                          _steps[index] = value;
                        },
                        decoration:
                            InputDecoration(labelText: 'Langkah ${index + 1}'),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _removeStep(index),
                    ),
                  ],
                );
              }),
              Center(
                child: TextButton(
                  onPressed: _addStep,
                  child: const Text('Tambah Langkah'),
                ),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: _saveRecipe,
                  child: const Text('Simpan Perubahan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
