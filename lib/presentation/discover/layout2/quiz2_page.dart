import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ipm_project/data/quiz_question.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizTwoPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizTwoPage> {
  int currentQuestionIndex = 0;
  int score = 0;
  String? selectedOption;
  bool isAnswerSelected = false;
  bool isCorrect = false;
  Timer? _questionTimer;
  static const int questionTimeLimit = 20; // 20 seconds for each question
  int remainingTime = questionTimeLimit;

  @override
  void initState() {
    super.initState();
    _startQuestionTimer();
  }

  List<QuizQuestion> sampleQuestions = [
    QuizQuestion(
      question: "O Mosasaurus era um tipo de que animal?",
      options: ["Lagarto Marinho", "Baleia", "Tubarão", "Ave"],
      correctAnswer: "Lagarto Marinho",
    ),
    QuizQuestion(
      question: "Ao que se deveu a extinção do Cretáceo-Terciário (K-T), ",
      options: ["Subida do nível dos oceanos", "Vulcanismo maciço", "Alterações climáticas", "A colisão de um asteróide com a Terra"],
      correctAnswer: "A colisão de um asteróide com a Terra",
    ),
    QuizQuestion(
      question: "Qual é o maior invertebrado do planeta?",
      options: ["Lula-Gigante", "Ostra gigante", "Lula-Colossal", "Caranguejo-aranha gigante"],
      correctAnswer: "Lula-Colossal",
    ),
    QuizQuestion(
      question: 'Quem foi o "pai da evolução"?',
      options: ["Darwin", "Einstein", "Galileu", "Newton"],
      correctAnswer: "Darwin",
    ),
    QuizQuestion(
      question: "De que se alimentavam os Espinossauros?",
      options: ["Insetos", "Mamíferos", "Plantas", "Peixes"],
      correctAnswer: "Peixes",
    ),
  ];

  void _startQuestionTimer() {
    _questionTimer?.cancel(); // Cancel any existing timer.
    _questionTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        timer.cancel();
        _timeIsUp(); // Call this when the time is up.
      }
    });
  }

  void _timeIsUp() {
    // Handle what happens when the time is up, e.g., move to next question
    // or show a time's up message.
    if (currentQuestionIndex < sampleQuestions.length - 1) {
      _goToNextQuestion();
    } else {
      // End of quiz logic
      _showQuizCompletionDialog();
    }
  }

  void _checkAnswer(String option) {
    bool correct = sampleQuestions[currentQuestionIndex].correctAnswer == option;

    setState(() {
      selectedOption = option;
      isCorrect = correct;
      isAnswerSelected = true;
      remainingTime++;
      if (correct) {
        score++;
      }
    });

    Future.delayed(Duration(seconds: 2), () {
      if (currentQuestionIndex < sampleQuestions.length - 1) {
        setState(() {
          currentQuestionIndex++;
          isAnswerSelected = false;
          remainingTime = questionTimeLimit;
        });
      } else {
        // Handle quiz completion here
        // For example, navigate to a result page or show a summary dialog
        _showQuizCompletionDialog();
      }
    });
  }

  void _goToNextQuestion() {
    // Logic to advance to the next question and reset timer
    setState(() {
      currentQuestionIndex++;
      selectedOption = null;
      isAnswerSelected = false;
      remainingTime = questionTimeLimit; // Reset the time for the next question
      _startQuestionTimer();
    });
  }

  @override
  void dispose() {
    _questionTimer?.cancel(); // Always cancel the timer to avoid memory leaks
    super.dispose();
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
          backgroundColor: const Color.fromARGB(255, 30, 30, 30),
          appBar: AppBar(
            title: Text('Quiz 2'),
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.05,),
                Container(
                  height: MediaQuery.sizeOf(context).height * 0.025,
                  width: MediaQuery.sizeOf(context).width * 0.7,
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(20),
                    value: (currentQuestionIndex + (isAnswerSelected ? 1 : 0)) / sampleQuestions.length,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.05,),
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.95, // Set the maximum width here
                  child: Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        currentQuestion.question,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.05,),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 50.0, // Size of the circular progress indicator
                      height: 50.0,
                      child: CircularProgressIndicator(
                        value: 1 - remainingTime / questionTimeLimit, // Inverse the progress to decrease clockwise
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[300]!),
                        backgroundColor: Colors.blue,
                        strokeWidth: 6, // Width of the progress indicator stroke
                      ),
                    ),
                    Text(
                      '$remainingTime', // Remaining time
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.grey[300], // Ensure the text color is visible on the progress indicator
                      ),
                    ),
                  ],
                ),
                // Reduced height for better layout
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.05,),
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
                      width: MediaQuery.sizeOf(context).width * 0.9,
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
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.075,),

              ],
            ),
          ),
        )
    );
  }

  Future<bool> _showExitPopup(BuildContext context) async {
    bool shouldPop = false;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 30, 30, 30),
          title: const Text('Are you sure you want to leave the quiz?', style: TextStyle(color: Colors.white),),
          content: const Text("Your progress will be lost!", style: TextStyle(color: Colors.white),),
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

  Future<void> _setQuizDone() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('quiz2', true);
  }

  Future<void> _setScore(int quizScore) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve the existing score or set it to 0 if it doesn't exist
    int existingScore = prefs.getInt('score') ?? 0;

    // Calculate the new total score by adding the current quiz score
    int totalScore = existingScore + quizScore*10;

    // Save the updated total score back to SharedPreferences
    await prefs.setInt('score', totalScore);
    await prefs.setInt('scoreQuiz2', score*10);
  }



  Future<void> _showQuizCompletionDialog() async {
    _setScore(score);
    _setQuizDone();

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 30, 30, 30),
          title: const Text(
            "Quiz Completed!",
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
              SizedBox(height: 10),
              const Text(
                "Your Score",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white
                ),
              ),
              SizedBox(height: 10), // Spacing
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2), // Square border
                  borderRadius: BorderRadius.circular(4), // Slightly rounded corners
                ),
                child: Text(
                  "${score*10}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20), // Spacing
              Text("Quiz 2/4", style: TextStyle(color: Colors.white),), // Example quiz number
            ],
          ),
          actions: [
            Center(
              child: TextButton(
                child: Text("CONTINUE EXPLORING"),
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


}
