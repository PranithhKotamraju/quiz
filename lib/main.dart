import 'package:flutter/material.dart';

import 'package:myquiz/quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = new QuizBrain();

void main() => runApp(MyQuiz());

class MyQuiz extends StatefulWidget {
  @override
  _MyQuizState createState() => _MyQuizState();
}

class _MyQuizState extends State<MyQuiz> {
  List<Widget> icons = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("MyQuiz"),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      quizBrain.getQuestionText(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.tealAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: FlatButton(
                  onPressed: () {
                    checkAnswer(true);
                  },
                  child: Text('True'),
                  color: Colors.green,
                ),
              )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: FlatButton(
                  onPressed: () {
                    checkAnswer(false);
                  },
                  child: Text('False'),
                  color: Colors.red,
                ),
              )),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: icons,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getQuestionAnswer();
    setState(() {

      if(quizBrain.isFinished()==true){
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
        ).show();

        quizBrain.reset();
        icons =[];
      }

      else{

        if (userPickedAnswer == correctAnswer) {
          print("correct");

          icons.add(Icon(Icons.check,color: Colors.green,),);
        } else {
          print("wrong");
          icons.add(Icon(Icons.close,color: Colors.red,),);
        }
      }


      quizBrain.getNextQuestion();
    });
  }
}
