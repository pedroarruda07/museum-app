import 'package:flutter/material.dart';

class PictureTakenPage extends StatelessWidget {
  final int page;
  final Color color1;
  final Color color2;
  final Color color3;

  const PictureTakenPage(
      {super.key,
      required this.page,
      required this.color1,
      required this.color2,
      required this.color3});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 30, 30, 30),
        appBar: AppBar(
          title: const Text(
            "Item Found",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 30, 30, 30),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Stack(children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color1,
                  color2, // Replace with your start color
                  color3, // Replace with your end color
                ],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.1,
                ),
                const Text(
                  "You have already found this item!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.15,
                ),
                const Text(
                  "And earned",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    "50",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Points!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 20),
                Text("Item $page/3",
                    style: const TextStyle(color: Colors.black)),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.15,
                ),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("CONTINUE EXPLORING"),
                ),
              ],
            ),
          ),
        ]));
  }
}
