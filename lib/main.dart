import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'QuizBrain.dart';

QuizBrain quizBrain = QuizBrain();
void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  List<Icon> scoreKeeper = [];
  void checkAns(bool userPick) {
    bool correctAns = quizBrain.getQuestionAns();
    setState(() {
      if (quizBrain.isFinished())
        {
          Alert(
            context: context,
            type: AlertType.warning,
            title: "Hmmm... something happened..",
            desc: "It seems like you've reached the end of the quiz.",
            buttons: [
              DialogButton(
                child: Text(
                  "Alright",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                width: 120,
              )
            ],
          ).show();
          quizBrain.reset();
          scoreKeeper.clear();
        }
      else {
        if (correctAns == userPick)
        {
          scoreKeeper.add(Icon(Icons.check, color: Colors.green));
        }
        else {
          scoreKeeper.add(Icon(Icons.close, color: Colors.red));
        }//wrong choice
        quizBrain.nextQuestion();
      }
    });
  }

  int qNum = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.green,),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                checkAns(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red,),
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false
                checkAns(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
