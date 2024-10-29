import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(RockPaperScissorsApp());

final Map<String, IconData> choiceIcons = {
  'Rock': FontAwesomeIcons.handBackFist,
  'Paper': FontAwesomeIcons.hand,
  'Scissors': FontAwesomeIcons.handScissors,
};

class RockPaperScissorsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RockPaperScissors(),

    );
  }
}

class RockPaperScissors extends StatefulWidget {
  @override
  _RockPaperScissorsState createState() => _RockPaperScissorsState();
}

class _RockPaperScissorsState extends State<RockPaperScissors> {
  String result = '';
  String player1Choice = '';
  String player2Choice = '';
  List<String> choices = ['Rock', 'Paper', 'Scissors'];

  void playGame() {
    setState(() {
      result = getResult(player1Choice, player2Choice);
    });
  }

  String getResult(String player1, String player2) {
    if (player1 == player2) return 'Empate!';
    if ((player1 == 'Rock' && player2 == 'Scissors') ||
        (player1 == 'Paper' && player2 == 'Rock') ||
        (player1 == 'Scissors' && player2 == 'Paper')) {
      return 'Jugador 1 gana!';
    } else {
      return 'Jugador 2 gana!';
    }

  }

  Widget buildChoiceButton(String choice, int player) {
    return SizedBox(
      width: 100,  // Set the desired width
      height: 100, // Set the desired height
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            if (player == 1) {
              player1Choice = choice;
            } else {
              player2Choice = choice;
            }
          });
        },
        child: Icon(choiceIcons[choice], size: 50, color: Colors.black),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(15), backgroundColor: (player == 1 && player1Choice == choice) ||
              (player == 2 && player2Choice == choice)
              ? Colors.blueAccent
              : Colors.grey[300],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          // Player 1 buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildChoiceButton('Rock', 1),
              buildChoiceButton('Paper', 1),
              buildChoiceButton('Scissors', 1),
            ],
          ),
          SizedBox(height: 80),
          ElevatedButton(
            onPressed: player1Choice.isNotEmpty && player2Choice.isNotEmpty
                ? playGame
                : null,
            child: Text('Jugar'),
          ),
          SizedBox(height: 80),
          SizedBox(height: 10),
          // Player 2 buttons

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildChoiceButton('Rock', 2),
              buildChoiceButton('Paper', 2),
              buildChoiceButton('Scissors', 2),
            ],
          ),
          SizedBox(height: 40),
          SizedBox(height: 40),
          Text(
            'Resultado: $result',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
