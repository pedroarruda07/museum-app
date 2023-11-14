import 'package:flutter/material.dart';
import 'package:ipm_project/data/quiz_question.dart';

class QuizOnePage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizOnePage> {
  int currentQuestionIndex = 0;
  int score = 0;
  String? selectedOption;
  bool isAnswerSelected = false;
  bool isCorrect = false;

  List<QuizQuestion> sampleQuestions = [
    QuizQuestion(
      question: "Teste",
      options: ["1", "2", "3", "4"],
      correctAnswer: "2",
    ),
    QuizQuestion(
      question: "What is Twitter?",
      options: ["bird", "web browser", "mobile app SDK", "dance"],
      correctAnswer: "bird",
    ),
  ];

  void _checkAnswer(String option) {
    bool correct = sampleQuestions[currentQuestionIndex].correctAnswer == option;

    setState(() {
      selectedOption = option;
      isCorrect = correct;
      isAnswerSelected = true;
    });

    if (correct) {
      score++;
    }

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        if (currentQuestionIndex < sampleQuestions.length - 1) {
          currentQuestionIndex++;
          isAnswerSelected = false;
        } else {
          // Quiz is finished, show results
          // You can navigate to a result page or display a dialog
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    QuizQuestion currentQuestion = sampleQuestions[currentQuestionIndex];

    return WillPopScope(
        onWillPop: () async {
      final shouldPop = await _showExitPopup(context);
      return shouldPop;
    },
    child: Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text('Quiz 1'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 30, 30, 30),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () async {
            if (await _showExitPopup(context)) {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  currentQuestion.question,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 100),
            ...currentQuestion.options.map((option) {
              bool isOptionCorrect = option == sampleQuestions[currentQuestionIndex].correctAnswer;
              Color buttonColor = Colors.white; // Default color

              if (isAnswerSelected) {
                if (selectedOption == option) {
                  // User's selected option
                  buttonColor = isCorrect ? Colors.green : Colors.red;
                } else if (isOptionCorrect) {
                  // Correct option when the user's choice is wrong
                  buttonColor = Colors.green;
                }
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  width: double.infinity, // Makes the button expand to the full width
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: buttonColor,
                      textStyle: TextStyle(fontSize: 18),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Adjust the corner radius
                      ),
                    ),
                    onPressed: !isAnswerSelected ? () => _checkAnswer(option) : () {},
                    child: Text(option),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    )
    );
  }

  Future<bool> _showExitPopup(BuildContext context) async {
    bool shouldPop = false; // Default to not allowing the pop

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[800],
          title: const Text('Are you sure you want to leave the quiz?', style: TextStyle(color: Colors.white),),
          content: const Text("Your progress will be lost and you won't be able to try again!", style: TextStyle(color: Colors.white),),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                shouldPop = true;
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
          ],
        );
      },
    );

    return shouldPop;
  }
  
}
