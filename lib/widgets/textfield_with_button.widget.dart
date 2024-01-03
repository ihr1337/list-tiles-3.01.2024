import 'package:flutter/material.dart';

class TextfieldWithButton extends StatefulWidget {
  final String textFieldValue;
  final Function(
    String key,
    dynamic value,
    int officeIndex,
  ) onTap;

  final String itemKey;
  final int officeIndex;

  const TextfieldWithButton({
    super.key,
    required this.textFieldValue,
    required this.onTap,
    required this.itemKey,
    required this.officeIndex,
  });

  @override
  State<TextfieldWithButton> createState() => _TextfieldWithButtonState();
}

class _TextfieldWithButtonState extends State<TextfieldWithButton> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.textFieldValue);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
            ),
          ),
          ElevatedButton(
            onPressed: () => widget.onTap(
              widget.itemKey,
              _controller.text,
              widget.officeIndex,
            ),
            child: const Icon(Icons.check),
          )
        ],
      ),
    );
  }
}
