import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      debugShowCheckedModeBanner: false,
      home: TicTacToeGame(),
    );
  }
}

class TicTacToeGame extends StatefulWidget {
  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  List<String> _board = List.filled(9, '');
  String _currentPlayer = 'X';
  String _result = '';
  List<int> _winningCombo = [];

  void _handleTap(int index) {
    if (_board[index] == '' && _result == '') {
      setState(() {
        _board[index] = _currentPlayer;
        if (_checkWinner(_currentPlayer)) {
          _result = 'Player $_currentPlayer Wins!';
        } else if (!_board.contains('')) {
          _result = 'It\'s a Draw!';
        } else {
          _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
        }
      });
    }
  }

  bool _checkWinner(String player) {
    List<List<int>> winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var pattern in winPatterns) {
      if (_board[pattern[0]] == player &&
          _board[pattern[1]] == player &&
          _board[pattern[2]] == player) {
        _winningCombo = pattern;
        return true;
      }
    }
    return false;
  }

  void _resetGame() {
    setState(() {
      _board = List.filled(9, '');
      _currentPlayer = 'X';
      _result = '';
      _winningCombo = [];
    });
  }

  Widget _buildGridItem(int index) {
    Color textColor =
        _board[index] == 'X' ? Colors.lightBlueAccent : Colors.pinkAccent;
    bool isWinnerCell = _winningCombo.contains(index);

    return GestureDetector(
      onTap: () => _handleTap(index),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color:
              isWinnerCell ? Colors.green.withOpacity(0.4) : Colors.white10,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: Center(
          child: AnimatedScale(
            scale: _board[index].isNotEmpty ? 1.0 : 0.0,
            duration: Duration(milliseconds: 200),
            child: Text(
              _board[index],
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const LinearGradient(
        colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, 500, 800)).transformToMaterialColor(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 30),
            Center(
              child: Text(
                _result.isEmpty ? 'Current Turn: $_currentPlayer' : _result,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: 9,
                itemBuilder: (_, index) => _buildGridItem(index),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: ElevatedButton.icon(
                onPressed: _resetGame,
                icon: Icon(Icons.refresh, color: Colors.white),
                label: Text(
                  'Reset Game',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  padding:
                      EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Extension to allow gradient background
extension MaterialColorExtension on Shader {
  MaterialColor transformToMaterialColor() {
    return MaterialColor(0xFF4A00E0, {
      50: Color(0xFFE3E0F5),
      100: Color(0xFFC1B3E6),
      200: Color(0xFF9D82D7),
      300: Color(0xFF7940C9),
      400: Color(0xFF6520BD),
      500: Color(0xFF4A00E0),
      600: Color(0xFF4300C3),
      700: Color(0xFF3700A1),
      800: Color(0xFF2B007F),
      900: Color(0xFF1E005D),
    });
  }
}
