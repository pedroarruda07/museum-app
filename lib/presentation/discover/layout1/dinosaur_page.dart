import 'package:flutter/material.dart';
import 'package:ipm_project/presentation/AR_page.dart';

class DinossaurPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color.fromARGB(255, 30, 30, 30),
        title: const Text('Explore the Museum',
            style: TextStyle(color: Colors.white)),
        centerTitle: true, // This centers the title
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // Positioned Base image
            Positioned.fill(
              child: Image.asset('assets/images/dinosaurs/velociraptor.jpg', fit: BoxFit.fill),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.05, // Adjust this value to move the entire group
              right: MediaQuery.of(context).size.width * 0.45, // Adjust this value to move the entire group
              child: Column(
                mainAxisSize: MainAxisSize.min, // Use minimum space
                children: <Widget>[
                  /*Text(
                    'Click here and',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),
                  ),*/
                  IconButton(
                    icon: Icon(Icons.vrpano_outlined), // Camera icon
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ObjectGesturesWidget()));
                    },
                    iconSize: 70.0, // Icon size
                    color: Colors.white, // Icon color
                  ),
                  const Text(
                    'Bring it to life!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),
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
