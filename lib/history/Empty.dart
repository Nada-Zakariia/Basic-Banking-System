// ignore_for_file: file_names
import 'package:bank_app/widgets/text_style.dart';
import 'package:flutter/material.dart';


class EmptyHistory extends StatefulWidget {
  const EmptyHistory({super.key});

  @override
  State<EmptyHistory> createState() => _EmptyHistoryState();
}

class _EmptyHistoryState extends State<EmptyHistory> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Textstyled(content: "No History Yet", size:35,color:const Color.fromARGB(255, 88, 47, 100).withOpacity(0.6) ,),
    );
  }
}
