import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipm_project/presentation/camera_page.dart';
import 'package:ipm_project/presentation/dinossaur_page.dart';

class DiscoverPage extends StatelessWidget {
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
              child: Image.asset('assets/images/mapa1.jpg', fit: BoxFit.fill),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.351,
              right: MediaQuery.of(context).size.width * 0.005,
              child: GestureDetector(
                onTap: () {
                  print("Clicked Arrow 2");
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.1, // Specify the width
                  height: MediaQuery.of(context).size.width * 0.1, // Use width to ensure the container is a circle
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.30),
                        spreadRadius: 5,
                        blurRadius: 15,
                        offset:
                        const Offset(0, 0), // changes position of shadow
                      ),
                    ],
                    color: Colors.black12, // Set to transparent or any other color
                    shape: BoxShape.rectangle, // Set the shape to a circle
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.145,
              right: MediaQuery.of(context).size.width * 0.005,
              child: GestureDetector(
                onTap: () {
                  print("Clicked Arrow 1");
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.1, // Specify the width
                  height: MediaQuery.of(context).size.width * 0.1, // Use width to ensure the container is a circle
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.30),
                        spreadRadius: 5,
                        blurRadius: 15,
                        offset:
                        const Offset(0, 0), // changes position of shadow
                      ),
                    ],
                    color: Colors.black12, // Set to transparent or any other color
                    shape: BoxShape.rectangle, // Set the shape to a circle
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              width: MediaQuery.of(context).size.width * 0.64,
              height: MediaQuery.of(context).size.height * 0.13,
              child: GestureDetector(
                onTap: () {
                  print("Clicked Dinosaur 4");
                },
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.208,
              right: 0,
              width: MediaQuery.of(context).size.width * 0.525,
              height: MediaQuery.of(context).size.height * 0.115,
              child: GestureDetector(
                onTap: () {
                  print("Clicked Dinosaur 3");
                },
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            // Clickable area 1 (Top-Left quarter)
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.0925,
              left: 0,
              width: MediaQuery.of(context).size.width * 0.21,
              height: MediaQuery.of(context).size.height * 0.335,
              child: GestureDetector(
                onTap: () {
                  print("Clicked Dinosaur 2");
                },
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            // Clickable area 2 (Bottom-Right quarter)
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.092,
              right: 0,
              width: MediaQuery.of(context).size.width * 0.295,
              height: MediaQuery.of(context).size.height * 0.265,
              child: GestureDetector(
                onTap: () {
                  print("Clicked Dinosaur 1");
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => DinossaurPage()));
                },
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 30, 30, 30),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded( // Expanded widget for the search bar
                child: TextFormField(
                  enabled: false,
                  style: TextStyle(color: Colors.white), // Text color
                  decoration: InputDecoration(
                    labelText: 'Search',
                    labelStyle: TextStyle(color: Colors.white), // Label text color
                    prefixIcon: Icon(Icons.search, color: Colors.white), // Icon color
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.white), // Border color
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              IconButton(
                icon: Icon(Icons.camera_alt), // Camera icon
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => CameraApp()));
                },
                color: Colors.white, // Choose a color that's visible on your map
              ),
              IconButton(
                icon: Icon(Icons.question_mark), // Camera icon
                onPressed: () {
                  // Add your button tap logic here, e.g., navigate to camera screen
                },
                color: Colors.white, // Choose a color that's visible on your map
              ),
            ],
          ),
        ),
      ),
    );
  }
}
