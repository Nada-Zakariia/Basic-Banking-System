import 'package:bank_app/widgets/bottom_navigator.dart';
import 'package:bank_app/widgets/text_style.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final send;
  const HomePage({super.key, this.send});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 222, 198, 242),
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        // ignore: avoid_unnecessary_containers
        child: Container(
          child: Column(
            children: [
              const Image(
                image: AssetImage('images/onlinebankingillustration.png'),
              ),
              Text("Welcome to our Banking System",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 20, letterSpacing: 1, color: Colors.white)),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BottomNavigator(
                            currentIndex: 0,
                            send: widget.send,
                          )));
                },
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(14),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                child: const Textstyled(content:"View Customers List" ,size: 18,color:Color.fromARGB(255, 183, 122, 200) ,)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
