import 'package:flutter/material.dart';
import 'package:q_check/services/category_service.dart';

// Gunakan konstanta warna yang sama dengan QuizPage agar konsisten
const Color kLightPurple = Color(0xFF7E57C2);
const Color kBackgroundCream = Color(0xFFFAF0E6);

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({super.key});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final TextEditingController _categoryController = TextEditingController();
  final CategoryService _categoryService = CategoryService();
  List<String> _currentCategories = [];

  @override
  void initState() {
    super.initState();
    _refreshCategories();
  }

  void _refreshCategories() {
    setState(() {
      _currentCategories = _categoryService.getCategories();
    });
  }

  void _saveCategory() {
    final text = _categoryController.text.trim();
    if (text.isNotEmpty) {
      _categoryService.addCategory(text);
      _categoryController.clear();
      _refreshCategories();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kategori "$text" berhasil ditambahkan!')),
      );
    }
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(65.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        child: AppBar(
          backgroundColor: kLightPurple,
          centerTitle: true,
          title: const Text(
            'Tambah Kategori',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          elevation: 4,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundCream,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          // Garis ungu muda di bawah AppBar (Konsisten dengan QuizPage)
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
            child: Container(
              height: 12,
              width: 380,
              color: const Color.fromARGB(255, 65, 45, 101),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Input Field
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextField(
                      controller: _categoryController,
                      decoration: const InputDecoration(
                        hintText: 'Nama Mata Pelajaran Baru...',
                        border: InputBorder.none,
                        icon: Icon(Icons.category, color: kLightPurple),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Tombol Simpan
                  ElevatedButton(
                    onPressed: _saveCategory,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kLightPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      'Simpan Kategori',
                      style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  const Text(
                    "Daftar Kategori Saat Ini:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
                  ),
                  const SizedBox(height: 10),
                  
                  // List Kategori
                  Expanded(
                    child: ListView.builder(
                      itemCount: _currentCategories.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: kLightPurple.withOpacity(0.2),
                              child: Text(
                                "${index + 1}",
                                style: const TextStyle(color: kLightPurple, fontWeight: FontWeight.bold),
                              ),
                            ),
                            title: Text(_currentCategories[index]),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
