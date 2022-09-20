// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously
import 'package:bank_app/widgets/bottom_navigator.dart';
import 'package:bank_app/widgets/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bank_app/database/sqldb.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Transfer extends StatefulWidget {
  final currentUserNum;
  final amount;

  const Transfer({super.key, this.currentUserNum, this.amount});

  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  SqlDb sqlDb = SqlDb();
  List users = [];
  String sender = "";
  Future readData() async {
    List<Map> response = await sqlDb.read("users");
    if (response.isEmpty) {
      await sqlDb.insertAllData();
      response = await sqlDb.read("users");
    }

    users.addAll(response);
    for (int i = 0; i < users.length; i++) {
      if (i == widget.currentUserNum) {
        sender = users[i]['name'];
        users.removeAt(i);
      }
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
        title: const Textstyled(
          content: "Select Customer to transfer",
          color: Colors.white,
          size: 17,
        ),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: ListView(
          children: [
            ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: users.length,
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () async {
                      await sqlDb.update(
                          "users",
                          {
                            'balance': int.parse('${users[i]['balance']}') +
                                widget.amount,
                          },
                          "id = ${users[i]['id']} ");
                      await Fluttertoast.showToast(
                          msg: "Transfered successfully!",
                          toastLength: Toast.LENGTH_LONG,
                          backgroundColor:
                              const Color.fromARGB(255, 88, 47, 100)
                                  .withOpacity(0.7),
                          textColor: Colors.white,
                          fontSize: 20,
                          gravity: ToastGravity.BOTTOM);
                      sqlDb.insert("History", {
                        'sender': sender,
                        'receiver': users[i]['name'],
                        'balance': widget.amount
                      });
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              const BottomNavigator(currentIndex: 0)));
                    },
                    child: Card(
                      shadowColor: const Color.fromARGB(255, 88, 47, 100),
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        title: Textstyled(
                          content: "${users[i]['name']}",
                          size: 18,
                          color: const Color.fromARGB(255, 88, 47, 100),
                        ),
                        trailing: Textstyled(
                          content: NumberFormat.currency(
                                  locale: 'en-GB',
                                  decimalDigits: 0,
                                  symbol: 'EG')
                              .format(int.parse("${users[i]['balance']}")),
                          size: 18,
                          color: const Color.fromARGB(255, 88, 47, 100),
                        ),
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
