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
          title: Text('Score : ${score}'),
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
                        'Question ${currentQuestionIndex + 1}/10',
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
                    margin: const EdgeInsets.fromLTRB(0, 40, 0, 50),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.deepPurple[200],
                          radius: 136,
                        ),
                        CircleAvatar(
                            backgroundColor: Colors.deepPurple[100],
                            foregroundImage:
                            AssetImage('${currentQuestion.getImage()}'),
                            radius: 130)
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
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          '${currentQuestion.question}',
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
                    width: width / 1.3,
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
                              backgroundColor: MaterialStatePropertyAll(Colors.lightGreen[400]),
                            ),
                            child: const Text('👍🏻', style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold
                            )),
                          ),
                          ElevatedButton(
                            // onPressed: () {
                            //   showDialog(
                            //     barrierDismissible: false,
                            //     context: context,
                            //     builder: (BuildContext context) {
                            //       return endGame();
                            //     },
                            //   );
                            // },
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
                              backgroundColor: MaterialStatePropertyAll(Colors.red[300]),
                            ),
                            child: const Text('👎🏻', style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold
                            )),
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
  AlertDialog showAnswer(nbQuestion, bool answer, bool choice) {
    var currentQuestion = nbQuestion;
    var textToShow = "Mauvaise réponse 🗿";
    var gifToShow = 'images/non.gif';
    if (answer == choice) {
      score++;
      textToShow = "Yass, bonne réponse ! ✨";
      gifToShow = 'images/oui.gif';
    }

    return AlertDialog(
      title: Text(textToShow, style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
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
              '${currentQuestion.explanation}',
              textAlign: TextAlign.center
          ),
          const SeparatorLine(),
        ],
      ),
      actions: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                currentQuestionIndex = currentQuestionIndex + 1;
              });
            },
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.deepPurple[500]),
            ),
            child: const Text('Question suivante', style: TextStyle(
                color: Colors.white,
                fontSize: 16
            )),
          ),
        ),
      ],
    );
  }

  // function to pass to the next question (triggered on close of showAnswer alert)
  void goNext () {
    if (currentQuestionIndex < questionData.questionList.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return endGame();
        },
      );
    }
  }

  // endgame popup with results + button to restart game
  AlertDialog endGame() {
    return AlertDialog(
      title: const Text('Votre score est de 10 points ! 🎉', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22), textAlign: TextAlign.center),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            // 'images/result-sup-5.gif',
            'images/result-und-5.gif',
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