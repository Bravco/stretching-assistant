import 'package:app/utils.dart' as utils;
import 'package:flutter/material.dart';

Future<String?> openDialog(BuildContext context, TextEditingController controller, String title, String labelText) {
  return showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: utils.color30,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: utils.color0Alt,
          fontSize: 20,
        ),
      ),
      content: TextField(
        autofocus: true,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: utils.color10),
          enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: utils.color10)),  
          focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: utils.color10)),
          border: const UnderlineInputBorder(borderSide: BorderSide(color: utils.color10)),
        ),
        maxLength: 8,
        textCapitalization: TextCapitalization.words,
        controller: controller,
        onSubmitted: (_) => submit(context, controller),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.done,
            size: 32,
            color: utils.color0Alt,
          ),
          onPressed: () => submit(context, controller),
        ),
      ],
    ),
  );
}

void submit(BuildContext context, TextEditingController controller) {
  Navigator.of(context).pop(controller.text);
  controller.clear();
}