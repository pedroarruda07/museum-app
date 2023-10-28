import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: ElevatedButton(
              onPressed: () {
                // Handle button press
              },
              child: Text('Discover',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            )),
            SizedBox(height: 30.0),  // Give some space between the buttons
            Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle button press
                  },
                  child: Text('Buy Ticket',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                )),
            SizedBox(height: 30.0),  // Give some space between the buttons
            Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle button press
                  },
                  child: Text('Store',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}