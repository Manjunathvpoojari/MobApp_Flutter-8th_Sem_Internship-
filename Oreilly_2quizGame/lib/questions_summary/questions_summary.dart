import 'package:flutter/material.dart';
import 'package:quiz_app/questions_summary/summery_item.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: summaryData.map((data) {
          return SummaryItem(data);
        }).toList(),
      ),
    );
  }
}
