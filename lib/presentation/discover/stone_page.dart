import 'package:flutter/material.dart';
import 'package:ipm_project/presentation/discover/model_page.dart';

class StonePage extends StatefulWidget {
  final String picture;
  const StonePage({super.key, required this.picture});
  @override
  _StonePage createState() => _StonePage(picture);
}

class _StonePage extends State<StonePage> {

  String model = "";
  final String picture;
  _StonePage(this.picture);

  @override
  void initState(){

    switch(picture){
      case "diamante": model = "diamond"; break;
      case "Ruby": model = "red_crystal"; break;
      case "emerald": model = "chaos_emerald"; break;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  const Color.fromARGB(255, 30, 30, 30),
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
              child: Image.asset('assets/images/stones/$picture.png', fit: BoxFit.fill),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.05, // Adjust this value to move the entire group
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ModelViewerPage(model: model)));
                },
                child: Container(
                padding: const EdgeInsets.fromLTRB(25, 5, 25, 35), // Add some padding if needed
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5), // Black color with 25% opacity
                      spreadRadius: 5, // Spread radius
                      blurRadius: 10, // Blur radius
                      offset: const Offset(0, 0), // Changes position of shadow
                    ),
                  ],
                  shape: BoxShape.circle, // Circular shape
                  color: Colors.grey.withOpacity(0.5),
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                     Icon(Icons.vrpano_outlined, size: 70.0, color: Colors.white,), // Camera icon
                     Text(
                      'Interact with it!',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),
                    ),
                  ],
                )),
              ),
            )
          ],
        ),
      ),
    );
  }


}
