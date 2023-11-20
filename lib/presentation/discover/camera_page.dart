import 'dart:math';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:ipm_project/presentation/discover/picture_taken_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CameraApp extends StatefulWidget {
  final int page;
  final String picture;
  final Color color1;
  final Color color2;
  final Color color3;
  const CameraApp({super.key, required this.page, required this.picture, required this.color1, required this.color2, required this.color3});

  @override
  _CameraAppState createState() => _CameraAppState(page, picture, color1, color2, color3);
}

class _CameraAppState extends State<CameraApp> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  Future<void>? _initializeControllerFuture;
  final int page;
  final String picture;
  final Color color1;
  final Color color2;
  final Color color3;
  _CameraAppState(this.page, this.picture, this.color1, this.color2, this.color3);

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    // Obtain a list of the available cameras on the device.
    _cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.
    final CameraDescription camera = _cameras!.first;

    // To create the CameraController.
    _controller = CameraController(
      enableAudio: false,
      camera,
      ResolutionPreset.medium,
    );

    // Next, initialize the controller.
    _initializeControllerFuture = _controller!.initialize().then((_) {
      // Ensure the camera is displayed the first time the widget is built.
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller?.dispose();
    super.dispose();
  }

  Future<void> pictureTaken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('camera$page', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 30, 30, 30),
        title: const Text('Find The Item',
            style: TextStyle(color: Colors.white)),
        centerTitle: true, // This centers the title
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color1,
                  color2, // Replace with your start color
                  color3, // Replace with your end color
                ],
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.3),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8, // 60% of screen width
              height: MediaQuery.of(context).size.height * 0.4, // Make it square
              child: FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),  // Make sure this matches the ClipRRect's borderRadius
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 196, 209, 214).withOpacity(0.25),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: OverflowBox(
                          alignment: Alignment.center,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: CameraPreview(_controller!),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
          const Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 25.0),
              child: Text('Find and Take a Photo of This Item', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
            ),
          ),
          Align(
            alignment: const Alignment(0, -0.7),
            child: Container( // Placeholder for the diamond image
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage('assets/images/find_items/$picture.png'), // Replace with your diamond image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: FloatingActionButton(
                child: const Icon(Icons.camera_alt),
                onPressed: () async {
                 /* Navigator.of(context).replace(
                  oldRoute: ModalRoute.of(context)!,
                  newRoute: MaterialPageRoute(builder: (context) => PictureTakenPage(page: page, color1: color1, color2: color2, color3: color3)),
                  );*/
                  //_showFailPopup(context);
                  int i = generateRandomDigit();
                  if (i < 3) _showCorrectPopup(context);
                  else _showFailPopup(context);

                },
              ),
            ),
          )
        ],
      ),
    );
  }

  int generateRandomDigit() {
    var random = Random();
    return random.nextInt(10); // Generates a random number between 0 and 9
  }

  void _showFailPopup(BuildContext context) {

     showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 30, 30, 30),
          title: const Text(
            'Wrong item',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            "That is not the item we were looking for!",
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Try again'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showCorrectPopup(BuildContext context) async {
    _setScore();
    pictureTaken();

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 30, 30, 30),
          title: const Text(
            "Item Found!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min, // Use minimum space
            children: [
              const SizedBox(height: 10),
              const Text(
                "You Earned",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white),
              ),
              const SizedBox(height: 10), // Spacing
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.white, width: 2), // Square border
                  borderRadius:
                  BorderRadius.circular(4), // Slightly rounded corners
                ),
                child: const Text(
                  "50",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Points",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white),
              ),
              const SizedBox(height: 20), // Spacing
              Text(
                "Item $page/3",
                style: const TextStyle(color: Colors.white),
              ), // Example quiz number
            ],
          ),
          actions: [
            Center(
              child: TextButton(
                child: const Text("CONTINUE EXPLORING"),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _setScore() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve the existing score or set it to 0 if it doesn't exist
    int existingScore = prefs.getInt('score') ?? 0;

    // Calculate the new total score by adding the current quiz score
    int totalScore = existingScore + 50;

    // Save the updated total score back to SharedPreferences
    await prefs.setInt('score', totalScore);
  }

}
