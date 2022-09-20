import 'package:bank_app/home_page.dart';
import 'package:bank_app/widgets/text_style.dart';
import 'package:bank_app/transfer_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bank_app/database/sqldb.dart';
import 'package:intl/intl.dart';

class UserProfile extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final num;
  final List user;
  final String imageUrl;
  const UserProfile(
      {super.key, this.num, required this.user, required this.imageUrl});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController amount;
  SqlDb sqlDb = SqlDb();
  @override
  void initState() {
    amount = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future openDialog() => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor:
                const Color.fromARGB(255, 222, 198, 242).withOpacity(0.9),
            title: const Textstyled(
              content: "Enter Amount of Money",
              size: 15,
              color: Colors.white,
            ),
            content: Form(
              key: formstate,
              child: TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter Valid Amount";
                  } else if (int.parse(value) >
                          widget.user[widget.num]['balance'] ||
                      int.parse(value) == 0) {
                    return "Enter Valid Amount";
                  }
                  return null;
                },
                autofocus: true,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 222, 198, 242))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 190, 146, 227))),
                    hintText: "Enter Amount",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(
                            fontSize: 18,
                            letterSpacing: 2,
                            color: const Color.fromARGB(255, 88, 47, 100))),
                controller: amount,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  var formdata = formstate.currentState;
                  if (formdata!.validate()) {
                    await sqlDb.update(
                        "users",
                        {
                          'balance': int.parse(
                                  '${widget.user[widget.num]['balance']}') -
                              int.parse(amount.text),
                        },
                        "id = ${widget.user[widget.num]['id']} ");
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Transfer(
                              currentUserNum: widget.num,
                              amount: int.parse(amount.text),
                            )));
                  }
                },
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                child: Text(
                  "Transfer",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: 16, letterSpacing: 2, color: Colors.white),
                ),
              )
            ],
          ),
        );
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 222, 198, 242),
        appBar: AppBar(
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
          elevation: 0,
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 222, 198, 242),
          leadingWidth: 100,
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
            content: "User Profile",
            size: 20,
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 150, 20, 0),
                child: Container(
                  height: MediaQuery.of(context).size.height - 220,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Theme.of(context).scaffoldBackgroundColor,
                            Theme.of(context)
                                .scaffoldBackgroundColor
                                .withOpacity(0.7),
                          ]),
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                ),
              ),
              Center(
                  child: Column(
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  CircleAvatar(
                      radius: 70, backgroundImage: AssetImage(widget.imageUrl)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    margin: const EdgeInsets.all(15),
                    child: Column(children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 222, 198, 242),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Column(
                          children: [
                            Textstyled(
                              content: '${widget.user[widget.num]['name']}',
                              size: 23,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Center(
                              child: Row(
                                children: [
                                  const Expanded(
                                    flex: 2,
                                    child: Icon(
                                      Icons.email,
                                      size: 25,
                                      color: Color.fromARGB(255, 88, 47, 100),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 15,
                                    child: Textstyled(
                                      content:
                                          '  ${widget.user[widget.num]['email']}',
                                      size: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            Textstyled(
                              content: NumberFormat.currency(
                                      locale: 'en-GB',
                                      decimalDigits: 0,
                                      symbol: 'EG')
                                  .format(int.parse(
                                      '${widget.user[widget.num]['balance']}')),
                              size: 40,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                      // ignore: avoid_unnecessary_containers
                      Container(
                        margin: const EdgeInsets.all(30),
                        child: Column(children: [
                          TextButton(
                            onPressed: () {
                              //
                              openDialog();
                            },
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(14),
                                backgroundColor:
                                    const Color.fromARGB(255, 183, 122, 200)
                                        .withOpacity(0.6),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25))),
                            child: const Textstyled(
                              content: "Transfer Money",
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ]),
                      )
                    ]),
                  )
                ],
              )),
            ],
          ),
        ));
  }
}
