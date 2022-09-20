import 'package:bank_app/customer_profile.dart';
import 'package:bank_app/home_page.dart';
import 'package:bank_app/widgets/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bank_app/database/sqldb.dart';
import 'package:intl/intl.dart';

class ViewCustomers extends StatefulWidget {
  const ViewCustomers({super.key});

  @override
  State<ViewCustomers> createState() => _ViewCustomersState();
}

class _ViewCustomersState extends State<ViewCustomers> {
  SqlDb sqlDb = SqlDb();
  List users = [];
  Future readData() async {
    List<Map> response = await sqlDb.read("users");
    if (response.isEmpty) {
      await sqlDb.insertAllData();
      response = await sqlDb.read("users");
    }
    users.addAll(response);
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
        title: const Textstyled(
          content: "All Customers List",
          size: 20,
          color: Colors.white,
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
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UserProfile(
                                user: users,
                                num: i,
                                imageUrl: "${users[i]['imageUrl']}",
                              )));
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
                          color: const Color.fromARGB(255, 88, 47, 100),
                          size: 18,
                        ),
                        subtitle: Textstyled(
                          content: "${users[i]['email']}",
                          color: const Color.fromARGB(255, 183, 122, 200),
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
                                  .format(
                                      int.parse("${users[i]['balance']}  ")),
                              size: 18,
                              color: const Color.fromARGB(255, 88, 47, 100),
                            )
                          ],
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
