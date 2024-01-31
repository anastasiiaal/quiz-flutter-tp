import 'dart:io';
import 'package:flutter/material.dart';

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
                        const Column(
                          children: [
                            ElevatedButton(
                              onPressed: null,
                              child: Text('Start the quiz!'),
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