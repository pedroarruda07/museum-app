import 'package:flutter/material.dart';
import 'package:ipm_project/presentation/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExitPage extends StatelessWidget {

  final int score;
  final String discountCode = "125945572";

  const ExitPage({super.key, required this.score});

  Future<void> _resetScore() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt('score', 0);
    await prefs.setInt('scoreQuiz1', 0);
    await prefs.setInt('scoreQuiz2', 0);
    await prefs.setInt('scoreQuiz3', 0);
    await prefs.setInt('scoreGame', 0);
    await prefs.setBool('game', false);
  }

  Future<void> _setTicketScanned() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('ticket', false);
  }

  Future<void> _setQuizDone() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('quiz1', false);
    await prefs.setBool('quiz2', false);
    await prefs.setBool('quiz3', false);
    await prefs.setBool('stone1', false);
    await prefs.setBool('stone2', false);
    await prefs.setBool('stone3', false);
  }

  void _setPopupNotShown() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('popup1', false);
    prefs.setBool('popup2', false);
    prefs.setBool('popup3', false);
  }

  Future<void> _setTutorialNotShown() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('tutorial', false);
    await prefs.setBool('tutorialAR', false);
    await prefs.setBool('gameTutorial', false);
    await prefs.setBool('gameFirstTutorial', false);
  }

  Future<void> _resetPictureTaken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('camera1', false);
    await prefs.setBool('camera2', false);
    await prefs.setBool('camera3', false);
  }

  @override
  Widget build(BuildContext context) {
    _setTutorialNotShown();
    _setTicketScanned();
    _setQuizDone();
    _setPopupNotShown();
    _resetScore();
    _resetPictureTaken();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/background.jpg'), // Replace with your image path
            fit: BoxFit.cover, // This will cover the entire background
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 100),
              Stack(
                alignment: Alignment.center,
                children: [
                  // Shadow (Outline) Text
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildOutlinedText('Thank you for visiting us!', 25),

                    ],
                  ),
                  // Foreground Text
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildForegroundText('Thank you for visiting us!', 25),

                    ],
                  ),
                ],
              ),
              const SizedBox(height: 100),
              Stack(
                alignment: Alignment.center,
                children: [
                  // Shadow (Outline) Text
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildOutlinedText('Your final score was:', 20),

                    ],
                  ),
                  // Foreground Text
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildForegroundText('Your final score was:', 20),

                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Placeholder for box background
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.black, // Border color
                    width: 2.0, // Border width
                  ),
                ),
                child: Text(
                  score.toString(),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Stack(
                alignment: Alignment.center,
                children: [
                  // Shadow (Outline) Text
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildOutlinedText('You unlocked a ${score/20}% discount code!', 20),

                    ],
                  ),
                  // Foreground Text
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildForegroundText('You unlocked a ${score/20}% discount code!', 20),

                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Placeholder for box background
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                  border: Border.all(
                    color: Colors.black, // Border color
                    width: 2.0, // Border width
                  ),
                ),
                child: SelectableText(
                  discountCode,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Stack(
                alignment: Alignment.center,
                children: [
                  // Shadow (Outline) Text
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildOutlinedText('Use it in our online store!', 20),
                      //_buildOutlinedText('Museum'),
                    ],
                  ),
                  // Foreground Text
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildForegroundText('Use it in our online store!', 20),
                      // _buildForegroundText('Museum'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  // Shadow (Outline) Text
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildOutlinedText("You can use the code at any time when checking out", 13),
                      //_buildOutlinedText('Museum'),
                    ],
                  ),
                  // Foreground Text
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildForegroundText("You can use the code at any time when checking out", 13),
                      // _buildForegroundText('Museum'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 100),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.053,
                width: MediaQuery.of(context).size.width * 0.65,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).replace(
                      oldRoute: ModalRoute.of(context)!,
                      newRoute: MaterialPageRoute(builder: (context) => const WelcomePage()),
                    );
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // Adjust the radius here
                      ),
                    ),
                    side: MaterialStateProperty.all(const BorderSide(color: Colors.black, width: 3)), // Black outline
                  ),
                  child: const Text(
                    'BACK TO MAIN MENU',
                    style: TextStyle(fontSize: 20, ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForegroundText(String text, double size) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.bold,
        color: const Color.fromARGB(255, 196, 209, 214),
      ),
    );
  }

  Widget _buildOutlinedText(String text, double size) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.bold,
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4
          ..color = Colors.black,
      ),
    );
  }

}
