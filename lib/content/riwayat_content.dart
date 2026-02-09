import 'package:flutter/material.dart';

class HistoryItem {
  final String title;
  final String subtitle;
  final double progress;
  final String imagePath;

  HistoryItem({
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.imagePath,
  });
}

class RiwayatContent extends StatelessWidget {
  final Color primaryColor;
  final Color highlightColor;
  final Color cardColor;

   RiwayatContent({
    super.key,
    required this.primaryColor,
    required this.highlightColor,
    required this.cardColor,
  });

  final List<HistoryItem> historyItems =  [
    HistoryItem(
      title: 'quiz algoritma dasar',
      subtitle: 'materi kelas 10',
      progress: 0.80,
      imagePath: 'assets/quiz_image_1.png',
    ),
    HistoryItem(
      title: 'quiz algoritma dasar',
      subtitle: 'materi kelas 10',
      progress: 0.75,
      imagePath: 'assets/quiz_image_2.png',
    ),
    HistoryItem(
      title: 'quiz algoritma dasar',
      subtitle: 'materi kelas 10',
      progress: 0.90,
      imagePath: 'assets/quiz_image_3.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCalendarSection(),
          const SizedBox(height: 10),
          _buildHistoryList(),
        ],
      ),
    );
  }

  // ===========================
  // BAGIAN KALENDER
  // ===========================
  Widget _buildCalendarSection() {
    final List<int> days = List.generate(31, (index) => index + 1);
    final List<int> circledDays = [1, 2, 3, 4, 5, 6, 7];
    const int highlightedDay = 17;

    List<Widget> buildCalendarRows() {
      List<Widget> rows = [];
      List<Widget> dayWidgets = [];
      int dayCount = 1;
      int startDayOffset = 1;

      for (int i = 0; i < startDayOffset; i++) {
        dayWidgets.add(const SizedBox(width: 40, height: 40));
      }

      for (int day in days) {
        bool isCircled = circledDays.contains(day);
        bool isHighlighted = day == highlightedDay;

        dayWidgets.add(Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: isCircled
                ? Border.all(color: primaryColor, width: 2)
                : null,
            color: isHighlighted ? highlightColor : Colors.transparent,
          ),
          child: Text(
            '$day',
            style: TextStyle(
              fontWeight: isCircled || isHighlighted
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ));

        if ((dayCount + startDayOffset) % 7 == 0) {
          rows.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.from(dayWidgets),
          ));
          dayWidgets.clear();
        }
        dayCount++;
      }

      if (dayWidgets.isNotEmpty) {
        while (dayWidgets.length < 7) {
          dayWidgets.add(const SizedBox(width: 40, height: 40));
        }
        rows.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.from(dayWidgets),
        ));
      }

      return rows;
    }

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: primaryColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('2025',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
          const Text('september',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('sun', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('mon', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('tue', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('wed', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('thu', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('fri', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('sat', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          ...buildCalendarRows(),
        ],
      ),
    );
  }

  // ===========================
  // LIST CARD SEPERTI QUIZCARD
  // ===========================
  Widget _buildHistoryList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: historyItems.map((item) {
          return Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade300,
                    image: DecorationImage(
                      image: AssetImage(item.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        item.subtitle,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: LinearProgressIndicator(
                              value: item.progress,
                              backgroundColor: Colors.grey.shade300,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFF8E24AA),
                              ),
                              borderRadius: BorderRadius.circular(5),
                              minHeight: 8,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${(item.progress * 100).toInt()}%',
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
