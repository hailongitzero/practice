import 'package:flutter/material.dart';

class KenoPage extends StatelessWidget {
  final String username;
  final statistic = [
    Keno('Chẵn', 5),
    Keno('Lẽ', 2),
    Keno('Hoà', 3),
  ];

  KenoPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User: $username!'),
      ),
      body: Center(
          child: SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Content Title
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Keno là một loại hình chơi sổ xố của Vietlott', // Customize the title text
                      style: TextStyle(
                        // Adjust font size, weight, etc.
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Your existing list view builder
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: statistic.length,
                    itemBuilder: (context, index) {
                      final item = statistic[index];
                      return Row(
                        children: [
                          // Text Section
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(item.text!),
                          ),
                          Spacer(),
                          // Bar Section
                          Container(
                            width: item.count! * 10,
                            height: 10.0,
                            color: Colors.red,
                          ),
                          SizedBox(width: 100.0),
                          // Value Section
                          Text('${item.count}'),
                        ],
                      );
                    },
                  ),
                ],
              ))),
    );
  }
}

class Keno {
  final String? text;
  final int? count;
  Keno(this.text, this.count);
}
