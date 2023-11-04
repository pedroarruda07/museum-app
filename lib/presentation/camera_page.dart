import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}
// TODO: Camera is not turning off after leaving the page

class _CameraAppState extends State<CameraApp> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  Future<void>? _initializeControllerFuture;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Text('Find The Item',
            style: TextStyle(color: Color.fromARGB(255, 196, 209, 214))),
        centerTitle: true, // This centers the title
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 196, 209, 214)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment(0, 0.35),
            child: Container(
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
                            color: Color.fromARGB(255, 196, 209, 214).withOpacity(0.25),
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
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: CameraPreview(_controller!),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Text('Find and Take a Photo of This Diamond', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color.fromARGB(255, 196, 209, 214))),
            ),
          ),
          Align(
            alignment: Alignment(0, -0.75),
            child: Container( // Placeholder for the diamond image
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/dino-logo.png'), // Replace with your diamond image path
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
                child: Icon(Icons.camera_alt),
                onPressed: () async {
                  // TODO: Handle camera capture functionality
                },
              ),
            ),
          )
        ],
      ),
    );
  }

}
