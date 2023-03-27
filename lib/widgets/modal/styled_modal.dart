import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_ori/tokens/dart/dart_color.dart';
import 'package:flutter_ori/tokens/dart/dart_size.dart';

class StyledModal extends StatefulWidget {
  final String title;
  final Widget content;
  const StyledModal({super.key, required this.title, required this.content});

  @override
  State<StyledModal> createState() => _StyledModalState();
}

class _StyledModalState extends State<StyledModal> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(adrSize.radiusSmall))),
      contentPadding: EdgeInsets.zero,
      content: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(adrSize.radiusSmall),
                  topRight: Radius.circular(adrSize.radiusSmall)),
              color: adrColor.backgroundPrimaryContainer,
            ),
            width: MediaQuery.of(context).size.width * 0.5,
            height: 52,
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.only(left: 30.0, top: 10, bottom: 10),
                child: Text(
                  widget.title,
                  style: TextStyle(
                      fontSize: adrSize.fontHeading2,
                      fontWeight: FontWeight.bold),
                ),
              ),
              trailing: Padding(
                padding: const EdgeInsets.only(right: 14.0),
                child: Icon(Icons.close),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: widget.content,
          ),
        ],
      ),
    );
  }
}
