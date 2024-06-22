import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Flutter code sample for [showModalBottomSheet].

enum AnimationStyles { defaultStyle, custom, none }

const List<(AnimationStyles, String)> animationStyleSegments =
    <(AnimationStyles, String)>[
  (AnimationStyles.defaultStyle, 'Default'),
  (AnimationStyles.custom, 'Custom'),
  (AnimationStyles.none, 'None'),
];

class ModalBottomSheetExample extends StatefulWidget {
  const ModalBottomSheetExample({super.key});

  @override
  State<ModalBottomSheetExample> createState() =>
      _ModalBottomSheetExampleState();

  void callBack(int quantity) {
    print(quantity);
  }
}

class _ModalBottomSheetExampleState extends State<ModalBottomSheetExample> {
  Set<AnimationStyles> _animationStyleSelection = <AnimationStyles>{
    AnimationStyles.defaultStyle
  };
  AnimationStyle? _animationStyle;
  int quantity = 0;
  @override
  void initState() {
    // TODO: implement ==
    // return super == other;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Home'),
        previousPageTitle: '',
      ),
      child: _buildBody(context),
    );
  }

  @override
  Widget _buildBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(quantity.toString()),
          SegmentedButton<AnimationStyles>(
            selected: _animationStyleSelection,
            onSelectionChanged: (Set<AnimationStyles> styles) {
              setState(() {
                _animationStyle = switch (styles.first) {
                  AnimationStyles.defaultStyle => null,
                  AnimationStyles.custom => AnimationStyle(
                      duration: const Duration(seconds: 3),
                      reverseDuration: const Duration(seconds: 1),
                    ),
                  AnimationStyles.none => AnimationStyle.noAnimation,
                };
                _animationStyleSelection = styles;
              });
            },
            segments: animationStyleSegments
                .map<ButtonSegment<AnimationStyles>>(
                    ((AnimationStyles, String) shirt) {
              return ButtonSegment<AnimationStyles>(
                  value: shirt.$1, label: Text(shirt.$2));
            }).toList(),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            // Change icon as needed
            backgroundColor: Colors.blue, // Customize color
            foregroundColor: Colors.white, // Customize text color
            elevation: 6.0, // Adjust shadow effect
            shape: BeveledRectangleBorder(
              // Change shape (optional)
              borderRadius: BorderRadius.circular(10.0),
            ),
            mini: true, // Make it smaller (optional)
            child: Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                sheetAnimationStyle: _animationStyle,
                builder: (BuildContext context) {
                  var textController =
                      new TextEditingController(text: quantity.toString());
                  return SizedBox.expand(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(children: [
                            Image(
                              image: AssetImage('assets/images/logo.png'),
                              height: 200,
                              width: 200,
                            ),
                            SizedBox(
                                width:
                                    10), // Add some spacing between text field and buttons
                            ElevatedButton(
                              onPressed: () => {
                                setState(() {
                                  quantity--;
                                  textController.text = quantity.toString();
                                  // widget.callBack(quantity);
                                })
                              },
                              child: Text('-'),
                            ),
                            Expanded(
                              child: TextField(
                                controller: textController,
                                decoration: InputDecoration(hintText: ''),
                              ),
                            ),
                            SizedBox(
                                width: 5), // Add some spacing between buttons
                            ElevatedButton(
                              onPressed: () => {
                                setState(() {
                                  quantity++;
                                  textController.text = quantity.toString();
                                  // widget.callBack(quantity);
                                })
                              },
                              child: Text('+'),
                            ),
                          ]),
                          const Text('Modal bottom sheet'),
                          ElevatedButton(
                            child: const Text('Close'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
