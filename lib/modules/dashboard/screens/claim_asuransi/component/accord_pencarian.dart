import 'package:flutter/material.dart';
import 'package:flutter_ori/tokens/dart/dart_color.dart';
import 'package:flutter_ori/tokens/dart/dart_size.dart';
import 'dropdown_pencarian.dart';
import 'datatable/datatable_pencarian.dart';
import 'package:flutter_ori/tokens/aether.dart';
import 'package:collection/collection.dart';

class AccordionPencarian extends StatefulWidget {
  const AccordionPencarian({Key? key}) : super(key: key);
  @override
  State<AccordionPencarian> createState() => _AccordionPencarianState();
}

class _AccordionPencarianState extends State<AccordionPencarian> {
  // Show or hide the content
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DropdownButtonPencarian(),
              SizedBox(
                width: 14,
              ),
              Container(
                width: 261,
                height: 46,
                child: TextFormField(
                  decoration: new InputDecoration(
                    contentPadding: EdgeInsets.all(6.0),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    hintText: "Cari data",
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              SizedBox(width: 14),
              ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Cari",
                    style: TextStyle(color: adrColor.textButtonPrimary),
                  ),
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(76, 46),
                      backgroundColor: Color(0xFFFFDD00),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )))
            ],
          ),
          SizedBox(height: 24),
          Container(
            width: MediaQuery.of(context).size.width,
            child: DataTablePencarian(),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
