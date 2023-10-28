import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipm_project/presentation/discover_page.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/dino-logo.png',
              scale: 1.25,
              width: MediaQuery.of(context).size.width * 0.7,
              //height: MediaQuery.of(context).size.height * 0.7,
              ),
            SizedBox(height: 50.0),
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: ElevatedButton(
              onPressed: ( ) {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => DiscoverPage()));
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