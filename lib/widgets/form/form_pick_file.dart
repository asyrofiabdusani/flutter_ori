import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_ori/tokens/aether.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FormFilePicker extends StatefulWidget {
  final String label;
  final String hint;
  const FormFilePicker({super.key, required this.label, required this.hint});

  @override
  State<FormFilePicker> createState() => _FormFilePickerState();
}

class _FormFilePickerState extends State<FormFilePicker> {
  @override
  Widget build(BuildContext context) {
    return AdTextFormField(
      onTap: () {
        selectFile();
      },
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.cloud_upload_outlined),
        hintText: widget.hint,
        labelText: widget.label,
      ),
    );
  }

  selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['pdf', 'doc', 'docx']);
    if (result != null) {
      setState(() {
        // txtFilePicker.text = result.files.single.name;
        // filePickerVal = File(result.files.single.path.toString());
      });
    } else {
      // User canceled the picker
    }
  }
}
