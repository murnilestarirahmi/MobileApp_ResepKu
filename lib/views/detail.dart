import 'dart:io';
import 'package:flutter/material.dart';
import 'package:resepku/models/recipe.dart';
import 'package:resepku/views/edit_recipe.dart';

class DetailPage extends StatefulWidget {
  final Recipe recipe;
  final Function(Recipe) onUpdate;
  final Function() onDelete;

  const DetailPage(
      {super.key,
      required this.recipe,
      required this.onUpdate,
      required this.onDelete});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Recipe _recipe;

  @override
  void initState() {
    super.initState();
    _recipe = widget.recipe;
  }

  void _editRecipe(BuildContext context) async {
    final updatedRecipe = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditRecipePage(
          recipe: _recipe,
          onSave: (updatedRecipe) {
            widget.onUpdate(updatedRecipe);
          },
        ),
      ),
    );

    if (updatedRecipe != null) {
      setState(() {
        _recipe = updatedRecipe;
      });
    }
  }

  void _deleteRecipe(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Resep'),
        content: const Text(
          'Apakah Anda yakin ingin menghapus resep ini?',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              widget.onDelete();
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Resep ${_recipe.name}',
          style: const TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _editRecipe(context),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteRecipe(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.file(File(_recipe.images)),
            ),
            const SizedBox(height: 16.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.category, color: Colors.black),
                      SizedBox(width: 8.0),
                      Text(
                        'Kategori',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Text(_recipe.category,
                      style: const TextStyle(color: Colors.black)),
                  const SizedBox(height: 16.0),
                  const Row(
                    children: [
                      Icon(Icons.schedule, color: Colors.black),
                      SizedBox(width: 8.0),
                      Text(
                        'Total Waktu Pembuatan',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Text(_recipe.totalTime,
                      style: const TextStyle(color: Colors.black)),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.grain, color: Colors.black),
                      SizedBox(width: 8.0),
                      Text(
                        'Bahan-Bahan',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  for (var ingredient in _recipe.ingredients)
                    Row(
                      children: [
                        const Text('• ', style: TextStyle(color: Colors.black)),
                        Expanded(
                          child: Text(ingredient,
                              style: const TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.assignment, color: Colors.black),
                      SizedBox(width: 8.0),
                      Text(
                        'Langkah Pembuatan',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  for (var i = 0; i < _recipe.steps.length; i++)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${i + 1}. ',
                            style: const TextStyle(color: Colors.black)),
                        Expanded(
                          child: Text(_recipe.steps[i],
                              style: const TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
