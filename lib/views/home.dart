import 'package:flutter/material.dart';
import 'package:quizmaker/views/create_quiz.dart';
import 'package:quizmaker/widgets/widgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black87),
        brightness: Brightness.light,
      ),
      body: Container(child: Column(children: [])),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CreateQuiz()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
