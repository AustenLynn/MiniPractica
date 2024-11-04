import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(RockPaperScissorsApp());



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
  final Map<String, IconData> choiceIcons = {
    'Piedra': FontAwesomeIcons.handBackFist,
    'Papel': FontAwesomeIcons.hand,
    'Tijeras': FontAwesomeIcons.handScissors,
  };
  String result = '';
  String player1Choice = '';
  String player2Choice = '';
  List<String> choices = ['Piedra', 'Papel', 'Tijeras'];



  String getResult(String player1, String player2) {
    if (player1 == player2) return 'Empate!';
    if ((player1 == 'Piedra' && player2 == 'Tijeras') ||
        (player1 == 'Papel' && player2 == 'Piedra') ||
        (player1 == 'Tijeras' && player2 == 'Papel')) {
      return 'Jugador Rojo gana!';
    } else {
      return 'Jugador Azul gana!';
    }
  }

  void playGame() {
    setState(() {
      result = getResult(player1Choice, player2Choice);
      showDialogWithResult(result);
    });
  }

  void resetGame() {
    setState(() {
      player1Choice = '';
      player2Choice = '';
      result = '';
    });
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


  Widget buildChoiceButton(String choice, int player) {
    return SizedBox(
      width: 100,
      height: 100,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            if (player == 1) {
              player1Choice = choice;
            } else {
              player2Choice = choice;
            }

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
      appBar: AppBar(
        title: Text('Piedra, papel o tijeras (Por turnos)'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildChoiceButton('Piedra', 1),
              buildChoiceButton('Papel', 1),
              buildChoiceButton('Tijeras', 1),
            ],
          ),
          SizedBox(height: 400),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildChoiceButton('Piedra', 2),
              buildChoiceButton('Papel', 2),
              buildChoiceButton('Tijeras', 2),
            ],
          ),
        ],
      ),
    );
  }
}
