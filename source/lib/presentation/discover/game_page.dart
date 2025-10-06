import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  double playerX = 0;
  List<FallingItem> items = [];
  int score = 0;
  int timeLeft = 100;
  Timer? gameTimer;
  double screenWidth = 0;
  double screenHeight = 0;
  Timer? updateTimer; // Declare this at the class level

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      await _showGameTutorial();
    });
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    updateTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Now it's safe to access MediaQuery and other inherited widgets
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    playerX = (screenWidth / 2) - 35;
  }

  void startGame() {
    gameTimer?.cancel();
    updateTimer?.cancel();

    items = [
      FallingItem(20, 100, screenWidth),
      FallingItem(170, 205, screenWidth),
      FallingItem(250, 70, screenWidth),
      FallingItem(300, 350, screenWidth),
      FallingItem(400, 185, screenWidth),
      FallingItem(100, 200, screenWidth),
      FallingItem(200, 0, screenWidth),
      FallingItem(300, 35, screenWidth),
    ];
    gameTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        timeLeft--;
        if (timeLeft <= 0) {
          timer.cancel();
          _showGameCompletionDialog();
        }
      });
    });
    // Update items' positions
    updateTimer = Timer.periodic(Duration(milliseconds: 20), (timer) {
      // Update every 50ms
      setState(() {
        for (var item in items) {
          item.fall(); // Make each item fall

          if (item.checkCollision(playerX, 65, 130, screenHeight, 50, 50)) {
            print("Collision detected");
            print("TYPE: " + item.type);

            if (item.type == 'good') {
              score++; // Reward for catching good items
            } else {
              if ((timeLeft - 5) < 0) {
                timeLeft = 0; // Penalize time for catching bad items
                _showGameCompletionDialog();
                gameTimer?.cancel();
              } else {
                timeLeft -= 5;
              }
            }
            item.reset();
            continue; // Skip the rest of the loop for this item
          }

          if (item.y >= screenHeight - 100) {
            item.reset();
          }
        }
      });
      if (timeLeft <= 0) {
        timer.cancel();

        // Game over logic here
      }
    });
  }

  void movePlayer(double dx) {
    setState(() {
      playerX += dx;
      if (playerX < 0) playerX = 0;
      if (playerX > MediaQuery.of(context).size.width - 70) {
        // Assuming player width is 50
        playerX = MediaQuery.of(context).size.width - 70;
      }
    });
  }

  Future<bool> _showExitPopup(BuildContext context) async {
    bool shouldPop = false;
    gameTimer?.cancel();
    updateTimer?.cancel();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 30, 30, 30),
          title: const Text(
            'Are you sure you want to leave the game?',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            "Your progress will be lost!",
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                shouldPop = true;
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
          ],
        );
      },
    );

    if (!shouldPop){
      gameTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          timeLeft--;
          if (timeLeft <= 0) {
            timer.cancel();
            _showGameCompletionDialog();
          }
        });
      });
      updateTimer = Timer.periodic(Duration(milliseconds: 20), (timer) {
        // Update every 50ms
        setState(() {
          for (var item in items) {
            item.fall(); // Make each item fall

            if (item.checkCollision(playerX, 65, 130, screenHeight, 50, 50)) {
              print("Collision detected");
              print("TYPE: " + item.type);

              if (item.type == 'good') {
                score++; // Reward for catching good items
              } else {
                if ((timeLeft - 5) <= 0) {
                  timeLeft = 0; // Penalize time for catching bad items
                  gameTimer?.cancel();
                  _showGameCompletionDialog();
                } else {
                  timeLeft -= 5;
                }
              }
              item.reset();
              continue; // Skip the rest of the loop for this item
            }

            if (item.y >= screenHeight) {
              item.reset();
            }
          }
        });
        if (timeLeft <= 0) {
          timer.cancel();

          // Game over logic here
        }
      });
    }

    return shouldPop;
  }

  Future<void> _setScore() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve the existing score or set it to 0 if it doesn't exist
    int existingScore = prefs.getInt('score') ?? 0;

    // Calculate the new total score by adding the current quiz score
    int totalScore = existingScore + score;

    // Save the updated total score back to SharedPreferences
    await prefs.setInt('score', totalScore);
    await prefs.setInt('scoreGame', score);
    await prefs.setBool('game', true);
  }

  Future<void> _showGameCompletionDialog() async {
    _setScore();

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 30, 30, 30),
          title: const Text(
            "Time is Over!",
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
                "Your Score",
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
                child: Text(
                  "${score}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20), // Spacing
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

  Future<void> _showGameTutorial() async {

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 30, 30, 30),
          title: const Text(
            "Welcome to Catch the Gemstones!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min, // Use minimum space
            children: [
              SizedBox(height: 10),
              Text(
                "Catch as many gemstones as you can in 100 seconds by moving the cart in the bottom of the screen!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white),
              ),

              SizedBox(height: 30), // Spacing
              Text(
                "But be careful with the stones and dirt as the time decreases when you catch them!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white),
              ),
            ],
          ),
          actions: [
            Center(
              child: TextButton(
                child: const Text("START"),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  startGame();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: () async {
      final shouldPop = await _showExitPopup(context);
      return shouldPop;
    },
    child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 30, 30, 30),
          title: Text('Catch the Gemstones'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () async {
              if (await _showExitPopup(context)) {
                Navigator.of(context).pop();
              }
            },
          ),
        ),
        body: Stack(children: [
          Container(
              width: double.infinity,
              height: double.infinity,
              child:
                  Image.asset('assets/game/background2.png', fit: BoxFit.fill)),
          GestureDetector(
            onHorizontalDragUpdate: (details) {
              movePlayer(details.delta.dx);
            },
            child: Stack(
              children: [
                Positioned(
                  left: playerX,
                  bottom: 0,
                  child: PlayerWidget(),
                ),
                ...items.map((item) => FallingItemWidget(item: item)),
                Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white, // Placeholder for box background
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.black, // Border color
                          width: 2.0, // Border width
                        ),
                      ),
                      child: Text(
                        'Score: $score',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white, // Placeholder for box background
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.black, // Border color
                          width: 2.0, // Border width
                        ),
                      ),
                      child: Text('Time: $timeLeft',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                    )),
              ],
            ),
          ),
        ])));
  }
}

class PlayerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/game/car.png',
      width: 70,
      height: 70,
      fit: BoxFit.fill,
    );
  }
}

class FallingItem {
  double x;
  double y = 0; // Starting position at the top
  late String type;
  static const double fallRate = 5; // Adjust for speed
  final double screenWidth;
  int assetPath;

  FallingItem(this.x, this.y, this.screenWidth)
      : type = Random().nextBool() ? 'good' : 'bad',
        assetPath = Random().nextInt(3);

  void fall() {
    y += fallRate;
  }

  void reset() {
    y = 0;
    x = Random().nextDouble() * (screenWidth - 50);
    type = Random().nextBool() ? 'good' : 'bad';
  }

  bool checkCollision(double playerX, double playerWidth, double playerHeight,
      double screenHeight, double itemWidth, double itemHeight) {
    // Collision occurs if any part of the item overlaps with any part of the player
    bool xOverlap = (x < playerX + playerWidth) && (x + itemWidth > playerX);
    bool yOverlap =
        (y < screenHeight) && (y + itemHeight > screenHeight - playerHeight);

    return xOverlap && yOverlap;
  }
}

class FallingItemWidget extends StatelessWidget {
  final FallingItem item;

  FallingItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: item.x,
      top: item.y,
      child: Image.asset(
        'assets/game/${itemPath(item.type)}',
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
    );
  }

  String itemPath(String type) {
    if (type == 'good') {
      switch (item.assetPath) {
        case 0:
          return '1.png';
          break;
        case 1:
          return '2.png';
          break;
        case 2:
          return '3.png';
          break;
        default:
          return '';
      }
    } else {
      switch (item.assetPath) {
        case 0:
          return '4.png';
          break;
        case 1:
          return '5.png';
          break;
        case 2:
          return '4.png';
          break;
        default:
          return '';
      }
    }
  }
}
