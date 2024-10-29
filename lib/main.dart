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
      showDialogWithResult(result);
    });
  }

  String getResult(String player1, String player2) {
    if (player1 == player2) return 'Empate!';
    if ((player1 == 'Rock' && player2 == 'Scissors') ||
        (player1 == 'Paper' && player2 == 'Rock') ||
        (player1 == 'Scissors' && player2 == 'Paper')) {
      return 'Jugador Rojo gana!';
    } else {
      return 'Jugador Azul gana!';
    }
  }

  void showDialogWithResult(String result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Resultado'),
          content: Text(result),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },

              child: Text('Jugar de nuevo'),
            ),
          ],
        );
      },
    );
  }

  void resetGame() {
    setState(() {
      player1Choice = '';
      player2Choice = '';
      result = '';
    });
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

            // Check if both players have made their choice to play the game
            if (player1Choice.isNotEmpty && player2Choice.isNotEmpty) {
              playGame();
            }
          });
        },
        child: Icon(choiceIcons[choice], size: 50, color: Colors.black),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(15),
          backgroundColor: (player == 1 && player1Choice == choice) ? Colors.redAccent:
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildChoiceButton('Rock', 1),
              buildChoiceButton('Paper', 1),
              buildChoiceButton('Scissors', 1),
            ],
          ),
          SizedBox(height: 400),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildChoiceButton('Rock', 2),
              buildChoiceButton('Paper', 2),
              buildChoiceButton('Scissors', 2),
            ],
          ),
        ],
      ),
    );
  }
}
