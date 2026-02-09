import 'package:flutter/material.dart';

class CategoryService {
  // Singleton pattern
  static final CategoryService _instance = CategoryService._internal();
  factory CategoryService() => _instance;
  CategoryService._internal();

  // Default categories
  final List<String> _categories = [
    'Matematika',
    'B. Indonesia',
    'B. Inggris',
    'PPLG',
    'DKV',
  ];

  List<String> getCategories() {
    return List.unmodifiable(_categories);
  }

  void addCategory(String category) {
    if (!_categories.contains(category)) {
      _categories.add(category);
    }
  }
}
