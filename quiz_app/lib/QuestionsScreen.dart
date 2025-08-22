import 'package:flutter/material.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();

}


class _QuestionsScreenState extends State<QuestionsScreen> {
  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(  // ✅ Wrap in Column
        children: [
          Text("Question goes here"),
          Spacer(), // ✅ Now Spacer works
          Text("Answer options here"),
        ],
      ),
    );
  }
}
