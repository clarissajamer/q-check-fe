import 'package:flutter/material.dart';

// =========================================
// 1. KONFIGURASI WARNA & MODEL
// =========================================
const Color kPrimaryPurple = Color(0xFF6A1B9A);
const Color kLightPurple = Color(0xFF7E57C2);
const Color kBackgroundCream = Color(0xFFFAF0E6);
const Color kAccentYellow = Color(0xFFFFD54F);
const Color kGreyInput = Color(0xFFEEEEEE);

class QuizOption {
  String text;
  bool isCorrect;
  QuizOption({required this.text, this.isCorrect = false});
}

class QuizQuestion {
  String questionText;
  int score;
  List<QuizOption> options;

  QuizQuestion({
    required this.questionText,
    this.score = 10,
    required this.options,
  });
}

// =========================================
// 2. WIDGET KONTEN (Kelas Utama: QuizContent)
// =========================================
class QuizContent extends StatefulWidget {
  final int index;
  final QuizQuestion question;
  final VoidCallback onRemoveOption; // Callback untuk update UI parent
  final VoidCallback onAddOption;    // Callback untuk update UI parent

  const QuizContent({
    super.key,
    required this.index,
    required this.question,
    required this.onRemoveOption,
    required this.onAddOption,
  });

  @override
  State<QuizContent> createState() => _QuizContentState();
}

class _QuizContentState extends State<QuizContent> {
  
  // Fungsi Pop-up Tambah Nilai
  void _showScoreDialog() {
    final scoreController = TextEditingController(text: widget.question.score.toString());
    
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Atur Nilai Soal"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Masukkan bobot nilai untuk pertanyaan ini:"),
            const SizedBox(height: 15),
            TextField(
              controller: scoreController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Nilai",
                border: OutlineInputBorder(),
                suffixText: "Poin",
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Batal", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: kPrimaryPurple),
            onPressed: () {
              setState(() {
                widget.question.score = int.tryParse(scoreController.text) ?? 0;
              });
              Navigator.pop(ctx);
            },
            child: const Text("Simpan", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: const Offset(0, 3)),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Strip Ungu di Kiri
            Container(
              width: 10,
              decoration: const BoxDecoration(
                color: kLightPurple,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
              ),
            ),
            // Konten Utama
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Input Pertanyaan
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: kGreyInput,
                        borderRadius: BorderRadius.circular(8),
                        border: const Border(bottom: BorderSide(color: kLightPurple, width: 2)),
                      ),
                      child: TextField(
                        controller: TextEditingController(text: widget.question.questionText)
                          ..selection = TextSelection.fromPosition(TextPosition(offset: widget.question.questionText.length)),
                        onChanged: (val) => widget.question.questionText = val,
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: "masukan pertanyaan",
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // List Opsi
                    ...List.generate(widget.question.options.length, (optIndex) {
                      return _buildOptionItem(optIndex);
                    }),

                    // Tombol Tambah Opsi
                    GestureDetector(
                      onTap: widget.onAddOption,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.circle, size: 10, color: Colors.grey),
                            const SizedBox(width: 12),
                            Text("tambahkan opsi", style: TextStyle(color: Colors.grey.shade600)),
                          ],
                        ),
                      ),
                    ),

                    const Divider(height: 24),

                    // Footer Nilai
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "tambah nilai (${widget.question.score})",
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: _showScoreDialog,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                              color: kAccentYellow,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.add, color: Colors.white, size: 20),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionItem(int optIndex) {
    final option = widget.question.options[optIndex];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.circle, color: kLightPurple, size: 14),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: TextEditingController(text: option.text)
                ..selection = TextSelection.fromPosition(TextPosition(offset: option.text.length)),
              onChanged: (val) => option.text = val,
              decoration: InputDecoration(
                hintText: "opsi ${optIndex + 1}",
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                border: InputBorder.none,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                for (var opt in widget.question.options) {
                  opt.isCorrect = false;
                }
                option.isCorrect = true;
              });
            },
            child: Icon(
              option.isCorrect ? Icons.check_circle : Icons.check_circle_outline,
              color: option.isCorrect ? Colors.green : Colors.grey.shade300,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
               widget.question.options.removeAt(optIndex);
               widget.onRemoveOption(); // Trigger rebuild parent
            },
            child: Icon(Icons.delete_outline, color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }
}