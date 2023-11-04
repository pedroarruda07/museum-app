import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipm_project/presentation/camera_page.dart';

class DiscoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color.fromARGB(255, 30, 30, 30),
        title: const Text('Explore the Museum',
            style: TextStyle(color: Color.fromARGB(255, 196, 209, 214))),
        centerTitle: true, // This centers the title
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 196, 209, 214)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // Positioned Base image
            Positioned.fill(
              child: Image.asset('assets/images/mapa.jpg', fit: BoxFit.fill),
            ),
            Positioned(
              top: 363,
              right: 2,
              child: GestureDetector(
                onTap: () {
                  print("Clicked Arrow 2");
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.1, // Specify the width
                  height: MediaQuery.of(context).size.width * 0.08, // Use width to ensure the container is a circle
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
                    shape: BoxShape.circle, // Set the shape to a circle
                  ),
                ),
              ),
            ),
            Positioned(
              top: 149,
              right: 2,
              child: GestureDetector(
                onTap: () {
                  print("Clicked Arrow 1");
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.1, // Specify the width
                  height: MediaQuery.of(context).size.width * 0.08, // Use width to ensure the container is a circle
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
                    shape: BoxShape.circle, // Set the shape to a circle
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              width: MediaQuery.of(context).size.width * 0.64,
              height: MediaQuery.of(context).size.height * 0.137,
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
              bottom: 470,
              right: 0,
              width: MediaQuery.of(context).size.width * 0.525,
              height: MediaQuery.of(context).size.height * 0.127,
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
              bottom: 100,
              left: 0,
              width: MediaQuery.of(context).size.width * 0.21,
              height: MediaQuery.of(context).size.height * 0.365,
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
              bottom: 100,
              right: 0,
              width: MediaQuery.of(context).size.width * 0.295,
              height: MediaQuery.of(context).size.height * 0.29,
              child: GestureDetector(
                onTap: () {
                  print("Clicked Dinosaur 1");
                },
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            Positioned(
                bottom: 15, // Adjust the value to your preference
                left: 65, // Adjust the value to your preference
                child: Container(
                    width: 50, // Width of the white circle
                    height: 50, // Height of the white circle
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.50),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset:
                              const Offset(0, 0), // changes position of shadow
                        ),
                      ],
                      color: Colors.white, // White background color
                      shape: BoxShape.circle, // Circular shape
                    )
                )
            ),
            Positioned(
              bottom: 10, // You can adjust the value to your preference
              left: 62.2, // You can adjust the value to your preference
              child: IconButton(
                icon: Icon(Icons.camera_alt), // Camera icon
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => CameraApp()));
                },
                iconSize: 40.0, // You can adjust the size to your preference
                color:
                    Colors.black, // Choose a color that's visible on your map
              ),
            ),
            Positioned(
                bottom: 15, // Adjust the value to your preference
                right: 65, // Adjust the value to your preference
                child: Container(
                    width: 50, // Width of the white circle
                    height: 50, // Height of the white circle
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.50),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset:
                              const Offset(0, 0), // changes position of shadow
                        ),
                      ],
                      color: Colors.white, // White background color
                      shape: BoxShape.circle, // Circular shape
                    ))),
            Positioned(
              bottom: 10, // You can adjust the value to your preference
              right: 59, // You can adjust the value to your preference
              child: IconButton(
                icon: Icon(Icons.question_mark), // Camera icon
                onPressed: () {
                  // Add your button tap logic here, e.g., navigate to camera screen
                },
                iconSize: 45.0, // You can adjust the size to your preference
                color:
                    Colors.black, // Choose a color that's visible on your map
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 30, 30, 30),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Search',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
