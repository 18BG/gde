import 'package:flutter/material.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  final int maxLines;

  const ExpandableTextWidget(
      {Key? key, required this.text, required this.maxLines})
      : super(key: key);

  @override
  _ExpandableTextWidgetState createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          maxLines: isExpanded ? null : widget.maxLines,
          overflow: TextOverflow.visible,
        ),
        InkWell(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Text(
            isExpanded ? 'Voir moins' : 'Voir plus',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}

// class ExpandableTextExample extends StatelessWidget {
//   final String longText =
//       'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Expandable Text Example'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ExpandableTextWidget(
//           text: longText,
//           maxLines: 3,
//         ),
//       ),
//     );
//   }
// }

