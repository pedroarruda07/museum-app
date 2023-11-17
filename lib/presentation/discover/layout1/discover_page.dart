import 'package:flutter/material.dart';
import 'package:ipm_project/presentation/discover/camera_page.dart';
import 'package:ipm_project/presentation/discover/layout1/dinosaur_page.dart';
import 'package:ipm_project/presentation/discover/layout1/quiz1_page.dart';
import 'package:ipm_project/presentation/discover/layout2/map2_page.dart';
import 'package:ipm_project/presentation/welcome_page.dart';
import 'package:ipm_project/presentation/discover/quiz_done_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _MyDiscoverPage createState() => _MyDiscoverPage();
}

class _MyDiscoverPage extends State<DiscoverPage> {
  final GlobalKey _oneKey = GlobalKey();
  final GlobalKey _twoKey = GlobalKey();
  final GlobalKey _threeKey = GlobalKey();
  final GlobalKey _fourKey = GlobalKey();
  final GlobalKey _fiveKey = GlobalKey();
  final GlobalKey _sixKey = GlobalKey();
  final GlobalKey _sevenKey = GlobalKey();
  final GlobalKey _eightKey = GlobalKey();

  Future<bool> _checkIfTutorialShown() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('tutorial') ?? false;
  }

  Future<void> _setTutorialShown() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('tutorial', true);
  }

  @override
  Widget build(BuildContext context) {
    _checkIfTutorialShown().then((tutorialShown) {
      if (!tutorialShown) {
        Future.delayed(Duration.zero, () {
          ShowCaseWidget.of(context).startShowCase([
            _oneKey,
            _twoKey,
            _threeKey,
            _fourKey,
            _fiveKey,
            _sixKey,
            _sevenKey,
            _eightKey,
          ]);
          _setTutorialShown();
        });
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor:  const Color.fromARGB(255, 30, 30, 30),
        title:
            const Text(
              'Explore the Museum',
              style: TextStyle(color: Colors.white),
            ),
        actions: [
          IconButton(
           // alignment: Alignment.centerRight,
            icon: const Icon(Icons.question_mark, color: Colors.white),
            onPressed: () async {
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool('tutorial', false);
              setState(() {});
            },
          ),
        ],
        centerTitle: true, // This centers the title
        leading: IconButton(
          icon: const Icon(Icons.home, color: Colors.white),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => WelcomePage()))
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
            _buildCenteredShowcase(context, '    Welcome to\n     The National History Museum!', _oneKey),
            _buildCenteredShowcase(context, 'Throughout your journey different challenges will be available to you', _fourKey),
            _buildCenteredShowcase(context, 'Complete them to earn points and be able to unlock rewards at our store!', _fiveKey),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.36,
              right: MediaQuery.of(context).size.width * 0.005,
              child: Showcase(
                key: _threeKey,
                description: 'Use the arrows to move through the museum',
                  descriptionAlignment: TextAlign.center,
                child: GestureDetector(
                onTap: () {
                  print("Clicked Arrow 2");
                  Navigator.of(context).replace(
                    oldRoute: ModalRoute.of(context)!,
                    newRoute: MaterialPageRoute(builder: (context) => Map2Page()),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.1, // Specify the width
                  height: MediaQuery.of(context).size.height * 0.05, // Use width to ensure the container is a circle
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
                    color: Colors.transparent, // Set to transparent or any other color
                    shape: BoxShape.rectangle, // Set the shape to a circle
                  ),
                ),
                )),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.145,
              right: MediaQuery.of(context).size.width * 0.005,
              child: GestureDetector(
                onTap: () {
                  print("Clicked Arrow 1");
                  Navigator.of(context).replace(
                    oldRoute: ModalRoute.of(context)!,
                    newRoute: MaterialPageRoute(builder: (context) => Map2Page()),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.1, // Specify the width
                  height: MediaQuery.of(context).size.height * 0.05, // Use width to ensure the container is a circle
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
                    color: Colors.transparent, // Set to transparent or any other color
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
              child: Showcase(
                key: _twoKey,
                description: 'Click to learn more about the exhibits shown or bring them to life with our Augmented Reality!',
                descriptionAlignment: TextAlign.center,
                child: GestureDetector(
                onTap: () {
                  print("Clicked Dinosaur 4");
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DinosaurPage(picture: "tri")));
                },
                child: Container(
                  color: Colors.transparent,
                ),
              ),
              )
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.208,
              right: 0,
              width: MediaQuery.of(context).size.width * 0.525,
              height: MediaQuery.of(context).size.height * 0.115,
              child: GestureDetector(
                onTap: () {
                  print("Clicked Dinosaur 3");
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DinosaurPage(picture: "tex")));
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DinosaurPage(picture: "long")));
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DinosaurPage(picture: "velociraptor")));
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
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Search',
                    labelStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(Icons.search, color: Colors.white),
                    contentPadding: const EdgeInsets.symmetric(vertical: 5),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.white), // Border color
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Showcase(
                key: _sevenKey,
                onBarrierClick: () => Future.delayed(Duration(seconds: 1), () {itemPopup(context); }),
                onTargetClick: () => Future.delayed(Duration(seconds: 1), () {itemPopup(context); }),
                disposeOnTap: true,
                description: 'Look for specific items and take a photo of them when you find them!',
                descriptionAlignment: TextAlign.center,
                child:IconButton(
                      icon: Icon(Icons.camera_alt), // Camera icon
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CameraApp()));
                      },
                      color: Colors.white, // Choose a color that's visible on your map
                    ),
              ),
              Showcase(
                key: _sixKey,
                description: 'Here you can access the quiz challenges!\nThere is one for every section of the museum',
                descriptionAlignment: TextAlign.center,
                child: IconButton(
                      padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                      icon: Image.asset('assets/icons/quiz_icon.png',), // Camera icon
                      onPressed: () async {
                        if(await _checkIfQuizDone()){
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                          int score = prefs.getInt('scoreQuiz1') ?? 0;
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => QuizDonePage(page: "1", score: score)));
                        } else Navigator.of(context).push(MaterialPageRoute(builder: (context) => QuizOnePage()));
                      },
                      color: Colors.white, // Choose a color that's visible on your map
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCenteredShowcase(BuildContext context, String text, GlobalKey key) {
    return Align(
      alignment: Alignment.center,
      child: Showcase(
        key: key, // Replace with your GlobalKey
        showArrow: false,
        title: text,
        titleAlignment: TextAlign.center,
        description: '',
        child: Container(width: 0, height: 0), // Empty Container as a placeholder
        // Other properties...
      ),
    );
  }

  Future<bool> _checkIfQuizDone() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('quiz1') ?? false;
  }

  Future<bool> _checkIfPopupShown() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('popup1') ?? false;
  }

  void _setPopupShown(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('popup1', value);
  }

  void itemPopup(BuildContext context) async {

    _checkIfPopupShown().then((popupShown) {
      if(!popupShown) {
        _setPopupShown(true);
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)), // this right here
              child: Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      "CHALLENGE!",
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 15.0),
                    Image.asset('assets/diamond.png', height: 100),
                    // Your diamond-shaped image asset
                    SizedBox(height: 15.0),
                    const Text(
                      "Find the diamond in the picture and take a photo of it!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Put your code here for what should happen when OK is tapped
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Put your code here for what should happen when Cancel is tapped
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.camera_alt), // Camera icon
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    });
  }

}
