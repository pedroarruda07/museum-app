import 'package:flutter/material.dart';

import '../welcome_page.dart';

class TicketCheckoutPage extends StatelessWidget {

  //final List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];

  //String selectedValue = 'Item 1';

  final List<String> items = List.generate(50, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text('Checkout'),
    centerTitle: true, // This centers the title
    ),
      body:
      Stack(
        children: <Widget> [
          Container(
              child: Stack(
                  children: <Widget> [
                    Positioned(
                        left: 10,
                        top: 30,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>  [
                              const Text(
                                'Enter your email:',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Container(
                                    width: 150,
                                    child: const TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Email',
                                        border: UnderlineInputBorder(),
                                      ),
                                    ),
                                  )
                              ),
                              SizedBox(height: 100),
                              const Text(
                                'Card Information',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                              const SizedBox(height: 50),
                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Container(
                                  width: 300,
                                  child: const TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Card Number',
                                      border: UnderlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 50),
                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Container(
                                  width: 300,
                                  child: const TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Expire Date',
                                      border: UnderlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 50),
                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Container(
                                  width: 300,
                                  child: const TextField(
                                    decoration: InputDecoration(
                                      hintText: 'CVV',
                                      border: UnderlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ),
                            ]
                        )

                    )

                  ])),
           Center(
             child: Padding(
                 padding: const EdgeInsets.all(50.0),
                 child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: <Widget> [
                       ElevatedButton(
                           onPressed: () {
                             // Perform booking logic here
                             // For example, you can show a confirmation dialog
                             showDialog(
                             context: context,
                             builder: (BuildContext context) {
                                return AlertDialog(
                                title: const Text('Done!'),
                                content: const Text('Thank you for choosing our museum! '
                                    'You will soon receive information about your purchased tickets in your email'),
                                  actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => const WelcomePage()),);
                                         },
                                    child: const Text('OK'),
                                              ),
                                          ],
                                      );
                             }
                            );
                           },
                           style: ElevatedButton.styleFrom(
                             fixedSize: const Size(200, 50),
                           ),
                           child: const Text('PLACE ORDER')
                       )
                    ]))
                 )
        ]
      )
    );
  }
}

class MyListView extends StatelessWidget {
  final List<String> items;

  MyListView({required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(items[index]),
        );
      },
    );
  }
}