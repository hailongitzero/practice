import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChessGame extends StatefulWidget {
  const ChessGame({super.key});
  static const title = 'Chess';
  static const homeIcon = Icon(CupertinoIcons.flag);

  @override
  State<ChessGame> createState() => _ChessGameState();
}

class _ChessGameState extends State<ChessGame> {
  final songTabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Chess Game'),
        previousPageTitle: '',
      ),
      child: Container(
        width: 300, // Adjust for desired size
        height: 300,
        // shrinkWrap: true,
        child: ChessTable(),
      ),
    );
  }
}

class ChessTable extends CustomPaint {
  ChessTable({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Card Game'),
        previousPageTitle: '',
      ),
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      bottom: false,
      left: false,
      right: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GridView.count(
            shrinkWrap: true,
            padding: EdgeInsets.all(16.0),
            crossAxisCount: 4, // Two columns
            // children: items.map((item) => _buildItem(item)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(Card item) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(10.0), // Add padding for content
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(5.0), // Rounded corners
      ),
      child: Center(
          // child: Text(
          //   item.name,
          //   style: TextStyle(fontSize: 16.0), // Adjust text style
          // ),
          ),
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final squareSize = size.width / 8; // Adjust for desired size

    // Draw background squares
    Paint whiteSquarePaint = Paint()..color = Colors.white;
    Paint blackSquarePaint = Paint()..color = Colors.black;
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        final isBlackSquare = (i + j) % 2 == 1;
        final paint = isBlackSquare ? blackSquarePaint : whiteSquarePaint;
        canvas.drawRect(
            Rect.fromLTWH(
                j * squareSize, i * squareSize, squareSize, squareSize),
            paint);
      }
    }

    // Draw border (optional)
    Paint borderPaint = Paint()
      ..color = Colors.brown
      ..strokeWidth = 2;
    canvas.drawRect(Offset.zero & size, borderPaint);
  }
}
