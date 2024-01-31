import 'dart:io';
import 'package:flutter/material.dart';
import 'package:quiz_flutter_tp/widgets/separator_line.dart';
import '../model/question.dart';
import '../model/question_data.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  FirstPageState createState() => FirstPageState();
}

class FirstPageState extends State<FirstPage> {
  int currentQuestionIndex = 0;
  final QuestionData questionData = QuestionData();

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double containerWidth = width / 1.1;
    double appBarHeight = AppBar().preferredSize.height;
    double height = MediaQuery.of(context).size.height - appBarHeight;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.deepPurple[200],
          title: const Text('✨ Quiz time! ✨', style: TextStyle(fontWeight: FontWeight.bold),),
          centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(
                    width: containerWidth,
                    height: 500,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: width / 1.17,
                                height: 410,
                                child: Image.asset(
                                  'images/questions.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ]
                        ),
                        const SizedBox(height: 10),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (BuildContext context) => QuizPage(context)));
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(Colors.deepPurple[500]),
                              ),
                              child: const Text('C\'est parti !', style: TextStyle(
                                color: Colors.white,
                              )),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  Widget QuizPage(BuildContext context) {
    Question currentQuestion = questionData.questionList[currentQuestionIndex];
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        // title: const TextTitleWidget(title: "user page")
        title: const Text('Score :'),
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
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                              return showAnswer();
                            },
                          );
                        },
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
                        onPressed: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return endGame();
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

  AlertDialog showAnswer() {
    return AlertDialog(
      title: const Text('Bonne réponse !', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'images/oui.gif',
            fit: BoxFit.cover,
            height: 200,
          ),
          const SizedBox(height: 18),
          const Text(
            "Le premier alunissage a eu lieu en 1969 tandis que les premières roulettes sont apparues en 1970",
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
              goNext();
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
}