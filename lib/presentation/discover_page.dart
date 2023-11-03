import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipm_project/presentation/camera_page.dart';

class DiscoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Clickable Image Areas'),
      // ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // Positioned Base image
            Positioned.fill(
              child: Image.asset('assets/images/mapa.jpg', fit: BoxFit.cover),
            ),
            // Clickable area 1 (Top-Left quarter)
            Positioned(
              top: 50,
              left: 50,
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.1,
              child: GestureDetector(
                onTap: () {
                  print("Top-Left area clicked!");
                },
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            // Clickable area 2 (Bottom-Right quarter)
            Positioned(
              bottom: 0,
              right: 0,
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.5,
              child: GestureDetector(
                onTap: () {
                  print("Bottom-Right area clicked!");
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => CameraApp()));
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