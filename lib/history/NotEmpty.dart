// ignore_for_file: file_names
import 'package:bank_app/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotEmpty extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final history;
  const NotEmpty({super.key, this.history});

  @override
  State<NotEmpty> createState() => _NotEmptyState();
}

class _NotEmptyState extends State<NotEmpty> {
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: ListView(
        children: [
          ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.history.length,
              itemBuilder: (context, i) {
                return Card(
                  elevation: 10,
                  color: const Color.fromARGB(255, 183, 122, 200),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(color: Colors.white)),
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Textstyled(
                      content: "${widget.history[i]['sender']} Transfer money",
                      size: 18,
                      color: Colors.white,
                    ),
                    subtitle: Textstyled(
                      content: "to ${widget.history[i]['receiver']}",
                      color: Colors.white,
                      size: 18,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Textstyled(
                          content: NumberFormat.currency(
                                  locale: 'en-GB',
                                  decimalDigits: 0,
                                  symbol: 'EG')
                              .format(int.parse(
                                  "${widget.history[i]['balance']}  ")),
                          size: 18,
                          color: const Color.fromARGB(255, 88, 47, 100),
                        )
                      ],
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
