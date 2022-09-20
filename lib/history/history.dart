import 'package:bank_app/history/Empty.dart';
import 'package:bank_app/history/NotEmpty.dart';
import 'package:bank_app/home_page.dart';
import 'package:bank_app/database/sqldb.dart';
import 'package:bank_app/widgets/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  SqlDb sqlDb = SqlDb();
  final history = [];
  // ignore: prefer_typing_uninitialized_variables
  var screen;
  Future readData() async {
    List<Map> response = await sqlDb.read("history");
    history.addAll(response);
    
    if (history.isEmpty) {
      
      screen = const EmptyHistory();
    } else {
      
      screen = NotEmpty(history:history);
    }
    // ignore: unnecessary_this
    if (this.mounted) {
      setState(() {});
    }
    return response;
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 222, 198, 242),
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HomePage()));
                  },
                  child: const Icon(
                    CupertinoIcons.house_fill,
                    size: 26,
                  )))
        ],
        backgroundColor: const Color.fromARGB(255, 222, 198, 242),
        leadingWidth: 80,
        elevation: 0,
        leading: TextButton.icon(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
          ),
          icon: const Icon(CupertinoIcons.chevron_left),
          onPressed: () {
            Navigator.of(context).pop();
          },
          label: const Text('Back'),
        ),
        title: const Textstyled(content:"History" ,color: Colors.white,size: 20,),
      ),
      body: screen,
    );
  }
}
