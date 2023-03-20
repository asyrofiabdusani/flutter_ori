import 'package:flutter/material.dart';
import 'package:flutter_ori/tokens/aether.dart';
import 'package:flutter_ori/tokens/dart/dart_font.dart';
import 'package:flutter_ori/tokens/dart/dart_size.dart';

class AppBar2 extends StatelessWidget {
  const AppBar2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 3,
            offset: Offset(2, 1), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 36, top: 14, bottom: 14),
                    child:
                        //locations
                        Row(children: [
                      Icon(Icons.location_on, color: Colors.blueAccent),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Text(
                          '0201 Bandung',
                          style: TextStyle(fontSize: adrFont.body1FontSize),
                        ),
                      ),

                      Text('|'),
                      // position
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.blueAccent,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  'Customer Service',
                                  style: TextStyle(
                                      fontSize: adrFont.body1FontSize),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ]),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // ring
                  IconButton(
                      onPressed: () {},
                      icon:
                          Icon(Icons.notifications, color: Colors.blueAccent)),
                  // account
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Row(children: [
                        Icon(Icons.account_circle_rounded,
                            color: Colors.blueAccent),
                        Padding(
                          padding: const EdgeInsets.only(left: 14, right: 0),
                          child: Text(
                            'Jony Sins',
                            style: TextStyle(fontSize: adrFont.body1FontSize),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 36),
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.keyboard_arrow_down,
                                  color: Colors.blueAccent)),
                        ),
                      ]),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
