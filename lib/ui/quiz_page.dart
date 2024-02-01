import 'package:flutter/material.dart';
import 'package:quiz_flutter_tp/widgets/separator_line.dart';
import '../model/question.dart';
import '../model/question_data.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  QuizPageState createState() => QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  int score = 0;
  final QuestionData questionData = QuestionData();

  @override
  Widget build(BuildContext context) {
    Question currentQuestion = questionData.questionList[currentQuestionIndex];
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[200],
          title: Text('Score : $score'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            child: Column(
              children: [
                const SizedBox(height: 18),
                Row(
                  children: [
                    SizedBox(
                      width: width-24,
                      child: Text(
                        'Question ${currentQuestionIndex + 1}/${questionData.questionList.length}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ],
                ),
                const SeparatorLine(),
                Row(children: [
                  Container(
                    width: width - 24,
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 30),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.deepPurple[200],
                          radius: 144,
                        ),
                        CircleAvatar(
                            backgroundColor: Colors.deepPurple[100],
                            foregroundImage:
                            AssetImage(currentQuestion.getImage()),
                            radius: 146)
                      ],
                    ),
                  ),
                ]),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: width - 44,
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          currentQuestion.question,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
                const SeparatorLine(),
                const SizedBox(height: 18),
                SizedBox(
                    width: width / 1.4,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return showAnswer(currentQuestion, currentQuestion.response, true);
                                },
                              );
                            },
                            // onPressed: checkAnswer(currentQuestion.response, true),
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(Colors.lightGreen[700]),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                              child: Text('👍🏻', style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold
                              )),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return showAnswer(currentQuestion, currentQuestion.response, false);
                                },
                              );
                            },
                            style:  ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(Colors.red[900]),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                              child: Text('👎🏻', style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold
                              )),
                            ),
                          ),
                        ]
                    )
                )
              ],
            ),
          ),
        )
    );
  }

  // popup when question answered : says right or wrong
  AlertDialog showAnswer(currentQuestion, bool answer, bool choice) {
    var textToShow = "Mauvaise réponse 🗿";
    var gifToShow = 'images/non.gif';
    var buttonText = "Question suivante";
    if (answer == choice) {
      score++;
      textToShow = "Yass, bonne réponse ! ✨";
      gifToShow = 'images/oui.gif';
    }
    if (currentQuestionIndex >= questionData.questionList.length - 1) {
      buttonText = "Résultats .. 👀";
    }

    return AlertDialog(
      title: Text(textToShow, style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            gifToShow,
            fit: BoxFit.cover,
            height: 200,
          ),
          const SizedBox(height: 18),
          Text(
              currentQuestion.explanation,
              textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          const SeparatorLine(),
        ],
      ),
      actions: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              goNext();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.deepPurple[500]),
            ),
            child: Text(buttonText, style: const TextStyle(
                color: Colors.white,
                fontSize: 16
            )),
          ),
        ),
      ],
    );
  }

  // function to pass to the next question (triggered on close of showAnswer alert)
  goNext () {
    if (currentQuestionIndex >= questionData.questionList.length - 1) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return endGame();
        },
      );
    } else {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  // endgame popup with results + button to restart game
  AlertDialog endGame() {
    var textToShow = "Bravo ! T'as eu $score points ! 🎉";
    var gifToShow = 'images/result-sup-5-1.gif';
    if (score <= 5) {
      textToShow = "Tu m'as déçu.. Que $score bonnes réponses 🥲";
      gifToShow = 'images/result-und-5.gif';
    }
    return AlertDialog(
      title: Text(textToShow, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22), textAlign: TextAlign.center),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            gifToShow,
            fit: BoxFit.cover,
            height: 200,
          )
        ],
      ),
      actions: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                score = 0;
                currentQuestionIndex = 0;
              });
            },
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.deepPurple[500]),
            ),
            child: const Text('✨ Rejouer !', style: TextStyle(
                color: Colors.white,
                fontSize: 16
            )),
          ),
        ),
      ],
    );
  }
}