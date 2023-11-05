import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipm_project/presentation/AR_page.dart';

class DinossaurPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // Positioned Base image
            Positioned.fill(
              child: Image.asset('assets/images/velociraptor.jpg', fit: BoxFit.fill),
            ),
            // Positioned "X" shaped button at the top right
            Positioned(
              top: 5,
              right: 0,
              child: IconButton(
                icon: Icon(Icons.close), // X shaped icon
                onPressed: () => Navigator.of(context).pop(), // Close the current page
                color: Colors.white, // Color for the icon, change as needed
                iconSize: 30, // Size of the icon, change as needed
              ),
            ),
            // New button positioned a bit lower than the middle of the screen
            Positioned(
              bottom: 75, // You can adjust the value to your preference
              right: (MediaQuery.of(context).size.width / 2) - 35,
              child: IconButton(
                icon: Icon(Icons.vrpano_outlined), // Camera icon
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ObjectGesturesWidget()));
                },
                iconSize: 90.0, // You can adjust the size to your preference
                color: Colors.white, // Choose a color that's visible on your map
              ),
            ),
            Positioned(
              bottom: 170, // You can adjust the value to your preference
              right: (MediaQuery.of(context).size.width / 2) - 45,
              child: const Text('Click here and', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
              ),
            ),
            Positioned(
              bottom: 60, // You can adjust the value to your preference
              right: (MediaQuery.of(context).size.width / 2) - 44,
              child: const Text('Bring it to life!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
            ),
            ),
          ],
        ),
      ),
    );
  }


}
