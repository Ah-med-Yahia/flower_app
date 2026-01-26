import 'package:flutter/material.dart';

class CategoriesTap extends StatelessWidget {
  final String? categoryId;

  const CategoriesTap({super.key, this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Categories Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            if (categoryId != null) ...[
              const SizedBox(height: 16),
              Text(
                'Selected Category ID: $categoryId',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
