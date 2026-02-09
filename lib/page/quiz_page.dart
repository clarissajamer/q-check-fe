import 'package:flutter/material.dart';
import 'package:q_check/content/quiz_content.dart';
import 'package:q_check/models/bank_soal.dart';
import 'package:q_check/services/api_service.dart';

// ================== WARNA (FIX ERROR) ==================
const Color _darkPurple = Color(0xFF3D2860);
const Color kLightPurple = Color(0xFF7243A9);
const Color kBackgroundCream = Color(0xFFFAF0E6);
const Color kAccentYellow = Color(0xFFF6DC43);
// ======================================================

class QuizPage extends StatefulWidget {
  // final Data quiz;

  // const QuizPage({super.key, required this.quiz});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<QuizQuestion> questions = [];

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final ApiService _apiService = ApiService();
  final double _customAppBarHeight = 65.0;

  @override
  void initState() {
    super.initState();
    _addQuestion();

    // titleController.text = widget.quiz.judul ?? '';
    // descriptionController.text = widget.quiz.deskripsi ?? '';
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  // =============================================================
  // 🔥 SIMPAN SOAL (FIXED – TANPA UBAH FLOW)
  // =============================================================
  Future<void> _handleSaveQuiz() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      for (final q in questions) {
        if (q.questionText.trim().isEmpty) continue;

        // pastikan minimal 2 opsi
        while (q.options.length < 4) {
          q.options.add(QuizOption(text: '-'));
        }

        final correctOption = q.options.firstWhere(
          (o) => o.isCorrect,
          orElse: () => q.options[0],
        );

        // await _apiService.createBankSoal(
        //   pertanyaan: q.questionText,
        //   opsiA: q.options[0].text.isNotEmpty ? q.options[0].text : '-',
        //   opsiB: q.options[1].text.isNotEmpty ? q.options[1].text : '-',
        //   opsiC: q.options[2].text.isNotEmpty ? q.options[2].text : '-',
        //   opsiD: q.options[3].text.isNotEmpty ? q.options[3].text : '-',
        //   jawabanBenar: correctOption.text,
        //   quizId: widget.quiz.id!,
        //   // idKategoriSoal: 1, // 🔥 WAJIB UNTUK BACKEND
        // );
      }

      if (mounted) Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Quiz & soal berhasil disimpan"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (mounted && Navigator.canPop(context)) Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Terjadi kesalahan: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _addQuestion() {
    setState(() {
      questions.add(
        QuizQuestion(
          questionText: '',
          options: [
            QuizOption(text: ''),
            QuizOption(text: ''),
          ],
        ),
      );
    });
  }

  void _deleteLastQuestion() {
    if (questions.isNotEmpty) {
      setState(() => questions.removeLast());
    }
  }

  void _addOptionToQuestion(int index) {
    setState(() {
      questions[index].options.add(QuizOption(text: ''));
    });
  }

  // ================= UI (TIDAK DIUBAH) =================

  PreferredSizeWidget _buildAppBar(BuildContext context, double height) {
    return PreferredSize(
      preferredSize: Size.fromHeight(height),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        child: AppBar(
          backgroundColor: kLightPurple,
          centerTitle: true,
          title: const Text(
            'tambah quiz',
            style: TextStyle(
              fontSize: 26,
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
      appBar: _buildAppBar(context, _customAppBarHeight),
      body: Column(
        children: [
          Container(
            height: 12,
            width: 330,
            decoration: const BoxDecoration(
              color: _darkPurple,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100, top: 20),
              child: Column(
                children: [
                  _buildQuizHeaderCard(),
                  const SizedBox(height: 20),
                  ...List.generate(questions.length, (index) {
                    return QuizContent(
                      index: index,
                      question: questions[index],
                      onAddOption: () => _addOptionToQuestion(index),
                      onRemoveOption: () => setState(() {}),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildFloatingNavBar(),
    );
  }

  Widget _buildQuizHeaderCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [kLightPurple, _darkPurple],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: titleController,
              style: const TextStyle(
                color: Colors.deepPurple,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                hintText: "judul quiz",
                border: InputBorder.none,
              ),
            ),
          ),
          TextField(
            controller: descriptionController,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            decoration: const InputDecoration(
              hintText: "deskripsi quiz",
              border: UnderlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingNavBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: kAccentYellow,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavButton(Icons.add, _addQuestion),
            _buildNavButton(Icons.undo, () {}),
            _buildNavButton(Icons.delete, _deleteLastQuestion),
            _buildNavButton(Icons.help_outline, () {}),
            _buildNavButton(Icons.send, _handleSaveQuiz),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 45,
        height: 45,
        decoration: const BoxDecoration(
          color: kLightPurple,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
