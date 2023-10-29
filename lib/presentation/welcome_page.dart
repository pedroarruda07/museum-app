import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipm_project/presentation/discover_page.dart';
import 'package:ipm_project/presentation/scan_ticket_page.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,  // Make sure the container takes the full width
        height: double.infinity,  // Make sure the container takes the full height
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'assets/images/background.jpg',
                fit: BoxFit.cover, // This is to make sure the image covers the entire container
              ),
            ),
            // Your original content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/dino-logo.png',
                    scale: 1.5,
                    width: MediaQuery.of(context).size.width * 0.7,
                  ),
                  SizedBox(height: 70.0),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: ElevatedButton(
                      onPressed: ( ) {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => QRViewExample()));
                      },
                      child: Text('Discover',
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
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
                    ),
                  ),
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
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}