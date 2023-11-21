import 'package:flutter/material.dart';
import 'package:ipm_project/data/ticket.dart';
import '../welcome_page.dart';

class TicketCheckoutPage extends StatelessWidget {
  final List<TicketInfo> tickets;
  TicketCheckoutPage({super.key, required this.tickets});

  @override
  Widget build(BuildContext context) {
    List<Widget> ticketWidgets = tickets.map((ticket) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Text(
          '${ticket.ticketType}: ${ticket.quantity}',
          style: TextStyle(fontSize: 16),
        ),
      );
    }).toList();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: const Text('Checkout'),
          centerTitle: true, // This centers the title
        ),
        body: Stack(children: <Widget>[
            SingleChildScrollView(
                child: Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 20),
                      const Text(
                        'Selected Tickets:',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      ...ticketWidgets,
                      SizedBox(height: 20),
                      const Text(
                        'Enter your email:',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 10, 10),
                          child: Container(
                            width: 150,
                            child: const TextField(
                              decoration: InputDecoration(
                                hintText: 'Email',
                                border: UnderlineInputBorder(),
                              ),
                            ),
                          )),
                      SizedBox(height: 50),
                      const Text(
                        'Card Information',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 10, 10),
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 10, 10),
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 10, 10),
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
                      const SizedBox(height: 60),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child:  ElevatedButton(
                            onPressed: () {
                              // Perform booking logic here
                              // For example, you can show a confirmation dialog
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Done!'),
                                      content: const Text(
                                          'Thank you for choosing our museum! '
                                              '\n\nYou will soon receive information about your purchased tickets in your email.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(200, 50),
                              primary: Colors.black87
                            ),
                            child: const Text('PLACE ORDER', style: TextStyle(color: Colors.white),)),
                      )
                    ]),
            ),

            )]));
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
