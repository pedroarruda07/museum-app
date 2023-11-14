import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipm_project/presentation/buyticket_page.dart';
import 'package:ipm_project/presentation/discover/layout1/discover_page.dart';
import 'package:ipm_project/presentation/discover/scan_ticket_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatelessWidget {

  Future<bool> _checkIfTickerScanned() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('ticket') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,  // Make sure the container takes the full width
        height: double.infinity,  // Make sure the container takes the full height
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'assets/images/background.jpg',
                fit: BoxFit.cover, // This is to make sure the image covers the entire container
              ),
            ),
            // Your original content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Shadow (Outline) Text
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildOutlinedText('Natural History'),
                          _buildOutlinedText('Museum'),
                        ],
                      ),
                      // Foreground Text
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildForegroundText('Natural History'),
                          _buildForegroundText('Museum'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Image.asset('assets/images/dino-logo.png',
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.35,
                  ),
                  const SizedBox(height: 40.0),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.053,
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: ElevatedButton(
                      onPressed: () async {
                        if(!await _checkIfTickerScanned()) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => QRViewExample()));
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DiscoverPage()));
                        }
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
                        'Start Exploring',
                        style: TextStyle(fontSize: 20, ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),  // Give some space between the buttons
                  Container(
                    height: MediaQuery.of(context).size.height * 0.053,
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => BuyTicketPage()));
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
                        'Book a Visit',
                        style: TextStyle(fontSize: 20,),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),  // Give some space between the buttons
                  Container(
                    height: MediaQuery.of(context).size.height * 0.053,
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle button press
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
                        'Store',
                        style: TextStyle(fontSize: 20, ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOutlinedText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4
          ..color = Colors.black,
      ),
    );
  }

  Widget _buildForegroundText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 196, 209, 214),
      ),
    );
  }


}