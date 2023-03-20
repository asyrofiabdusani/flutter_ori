import 'package:flutter/material.dart';
import 'package:flutter_ori/tokens/dart/dart_color.dart';
import 'package:flutter_ori/tokens/dart/dart_size.dart';

class Accordion extends StatefulWidget {
  final String title;
  final Widget content;

  const Accordion({Key? key, required this.title, required this.content})
      : super(key: key);
  @override
  State<Accordion> createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  // Show or hide the content
  bool _showContent = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Column(children: [
          // The title
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(adrSize.radiusSmall),
                  topRight: Radius.circular(adrSize.radiusSmall)),
              color: adrColor.backgroundPrimaryContainer,
            ),
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  widget.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  _showContent
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  size: 30,
                  color: Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    _showContent = !_showContent;
                  });
                },
              ),
            ),
          ),
          // Show or hide the content based on the state
          _showContent
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: widget.content,
                )
              : Container()
        ]),
      ),
    );
  }
}
