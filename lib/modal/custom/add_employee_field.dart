import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../const/const_color.dart';

class AddEmployeeField extends StatefulWidget {
  final String label;
  final Function? onTap;
  final List<TextInputFormatter> textInputType;
  final TextInputType keyboard;
  final int maxLength;
  final bool isCapital;
  final bool readOnly;

  final TextEditingController controller;

  const AddEmployeeField({
    Key? key,
    required this.label,
    required this.controller,
    required this.textInputType,
    required this.keyboard,
    required this.maxLength,
    this.isCapital = false,
    this.readOnly = false,
    this.onTap,
  }) : super(key: key);

  @override
  _AddEmployeeFieldState createState() => _AddEmployeeFieldState();
}

class _AddEmployeeFieldState extends State<AddEmployeeField> {
  final FocusNode focusNode = FocusNode();

  void closeKeyboard() {
    // Close the keyboard
    focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;
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
        Container(
          height: 28,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onTap: (){
                    widget.onTap!();
                  },
                  readOnly: widget.readOnly,
                  keyboardType: widget.keyboard,
                  inputFormatters: widget.textInputType,
                  maxLength: widget.maxLength,
                  textCapitalization: (widget.isCapital)
                      ? TextCapitalization.characters
                      : TextCapitalization.none,
                  cursorColor: ConstColor.blackText,
                  controller: widget.controller,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    counterText: "",
                    border: InputBorder.none,
                  ),
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
          height: 15,
        ),
      ],
    );
  }
}
