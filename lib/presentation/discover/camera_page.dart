import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraApp extends StatefulWidget {
  final String picture;
  const CameraApp({super.key, required this.picture});

  @override
  _CameraAppState createState() => _CameraAppState(picture);
}

class _CameraAppState extends State<CameraApp> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  Future<void>? _initializeControllerFuture;
  final String picture;
  _CameraAppState(this.picture);

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
