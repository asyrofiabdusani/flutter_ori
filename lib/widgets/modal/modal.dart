import 'package:flutter/material.dart';
import 'package:flutter_ori/widgets/modal/styled_modal.dart';
import 'package:flutter_ori/modules/claim_asuransi/components/form/form_data_nasabah.dart';

void main() {
  runApp(new MaterialApp(home: new Modal()));
}

class Modal extends StatefulWidget {
  @override
  _ModalState createState() => _ModalState();
}

class _ModalState extends State<Modal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return StyledModal(
                    title: "Banding - 1",
                    content: FormDataNasabah(),
                  );
                });
          },
          child: Text("Open Popup"),
        ),
      ),
    );
  }
}


// AlertDialog(
//                     contentPadding: EdgeInsets.zero,
//                     content: Stack(
//                       children: <Widget>[
//                         Positioned(
//                           right: -15.0,
//                           top: -15.0,
//                           child: InkResponse(
//                             onTap: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: CircleAvatar(
//                               radius: 12,
//                               child: Icon(
//                                 Icons.close,
//                                 size: 18,
//                               ),
//                               backgroundColor: Colors.red,
//                             ),
//                           ),
//                         ),
//                         Form(
//                           key: _formKey,
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: <Widget>[
//                               Container(
//                                 height: 60,
//                                 width: MediaQuery.of(context).size.width,
//                                 decoration: BoxDecoration(
//                                     color: Colors.yellow.withOpacity(0.2),
//                                     border: Border(
//                                         bottom: BorderSide(
//                                             color:
//                                                 Colors.grey.withOpacity(0.3)))),
//                                 child: Center(
//                                     child: Text("Contact Me",
//                                         style: TextStyle(
//                                             color: Colors.black54,
//                                             fontWeight: FontWeight.w700,
//                                             fontSize: 20,
//                                             fontStyle: FontStyle.italic,
//                                             fontFamily: "Helvetica"))),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.all(20.0),
//                                 child: Container(
//                                     height: 50,
//                                     decoration: BoxDecoration(
//                                         border: Border.all(
//                                             color:
//                                                 Colors.grey.withOpacity(0.2))),
//                                     child: Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Expanded(
//                                           flex: 1,
//                                           child: Container(
//                                             width: 30,
//                                             child: Center(
//                                                 child: Icon(Icons.person,
//                                                     size: 35,
//                                                     color: Colors.grey
//                                                         .withOpacity(0.4))),
//                                             decoration: BoxDecoration(
//                                                 border: Border(
//                                                     right: BorderSide(
//                                                         color: Colors.grey
//                                                             .withOpacity(
//                                                                 0.2)))),
//                                           ),
//                                         ),
//                                         Expanded(
//                                           flex: 4,
//                                           child: TextFormField(
//                                             decoration: InputDecoration(
//                                                 hintText: "Name",
//                                                 contentPadding:
//                                                     EdgeInsets.only(left: 20),
//                                                 border: InputBorder.none,
//                                                 focusedBorder: InputBorder.none,
//                                                 errorBorder: InputBorder.none,
//                                                 hintStyle: TextStyle(
//                                                     color: Colors.black26,
//                                                     fontSize: 18,
//                                                     fontWeight:
//                                                         FontWeight.w500)),
//                                           ),
//                                         )
//                                       ],
//                                     )),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(20.0),
//                                 child: ElevatedButton(
//                                   child: Container(
//                                     width: MediaQuery.of(context).size.width,
//                                     height: 60,
//                                     decoration: BoxDecoration(
//                                         gradient: LinearGradient(
//                                             begin: Alignment.topCenter,
//                                             end: Alignment.bottomCenter,
//                                             colors: [
//                                           Color(0xffc9880b),
//                                           Color(0xfff77f00),
//                                         ])),
//                                     child: Center(
//                                         child: Text(
//                                       "Submit",
//                                       style: TextStyle(
//                                           color: Colors.white70,
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.w800),
//                                     )),
//                                   ),
//                                   onPressed: () {},
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );