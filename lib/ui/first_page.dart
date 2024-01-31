import 'dart:io';
import 'package:flutter/material.dart';
import 'package:quiz_flutter_tp/widgets/separator_line.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  FirstPageState createState() => FirstPageState();
}

class FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double containerWidth = width / 1.1;
    double appBarHeight = AppBar().preferredSize.height;
    double height = MediaQuery.of(context).size.height - appBarHeight;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.deepPurple[200],
          // title: const TextTitleWidget(title: "user page")
          title: const Text('Quiz time!'),
          centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
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
                              child: const Text('Start the quiz!', style: TextStyle(
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
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        // title: const TextTitleWidget(title: "user page")
        title: const Text('Score'),
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
                      child: const Text(
                        'Question 1/10',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                            const AssetImage('images/cow.jpeg'),
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
                        child: const Text(
                          'L\'homme a marché sur la Lune avant d\'inventer la valise à roulette',
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
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: null,
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.lightGreen),
                        ),
                        child: Text('Vrai !', style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                        )),
                      ),
                      ElevatedButton(
                        onPressed: null,
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.redAccent),
                        ),
                        child: Text('Faux !', style: TextStyle(
                          color: Colors.white,
                            fontSize: 30,
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
}