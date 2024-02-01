import 'package:flutter/material.dart';
import 'package:quiz_flutter_tp/ui/quiz_page.dart';
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
                                    MaterialPageRoute(builder: (BuildContext context) => const QuizPage()));
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(Colors.deepPurple[500]),
                              ),
                              child: const Text('C\'est parti ! 👌🏻', style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
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
}