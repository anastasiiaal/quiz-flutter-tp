import 'package:flutter/material.dart';
import 'package:quiz_flutter_tp/ui/quiz_page.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

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
                    height: 510,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: width - 58,
                                height: 410,
                                child: Image.asset(
                                  'images/questions.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ]
                        ),
                        const SizedBox(height: 16),
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