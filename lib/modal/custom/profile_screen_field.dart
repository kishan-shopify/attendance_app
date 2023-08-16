import 'package:flutter/material.dart';

import '../const/const_color.dart';
import '../const/const_image.dart';

class ProfileScreenField extends StatefulWidget {
  final String label;
  final Function? onSave;
  final bool isEditIcon;

  final TextEditingController controller;

  const ProfileScreenField({
    Key? key,
    required this.label,
    this.onSave,
    required this.controller,
    this.isEditIcon = false,
  }) : super(key: key);

  @override
  _ProfileScreenFieldState createState() => _ProfileScreenFieldState();
}

class _ProfileScreenFieldState extends State<ProfileScreenField> {
  final FocusNode focusNode = FocusNode();
  bool readOnly = true;
  bool saveButton = false;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(onFocusChange);
  }

  @override
  void dispose() {
    focusNode.removeListener(onFocusChange);
    focusNode.dispose();
    super.dispose();
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Open the keyboard
      FocusScope.of(context).requestFocus(focusNode);
    }
  }

  void closeKeyboard() {
    // Close the keyboard
    focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          maxLines: 1,
          style: TextStyle(
            fontSize: size.width * 0.041,
            color: ConstColor.blackText.withOpacity(0.9),
            overflow: TextOverflow.visible,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 28,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  cursorColor: ConstColor.blackText,
                  controller: widget.controller,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  readOnly: readOnly,
                  onEditingComplete: () {
                    focusNode.unfocus();
                  },
                  style: TextStyle(
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.w600,
                    color: ConstColor.blackText.withOpacity(0.6),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              if (widget.isEditIcon)
                (saveButton)
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ConstColor.primary,
                        ),
                        onPressed: () {
                          closeKeyboard();
                        setState(() {
                          saveButton = false;
                        });
                          widget.onSave!();
                        },
                        child: Text("Save"))
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            saveButton = true;
                            readOnly = false;

                          });
                          if (!readOnly) {
                            widget.onSave?.call();
                            // Request focus on the text field
                            focusNode.requestFocus();
                          }
                        },
                        child: Image.asset(
                          ConstImage.edit,
                          height: 20,
                          width: 20,
                        ),
                      ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: ConstColor.grey.withOpacity(0.9),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
