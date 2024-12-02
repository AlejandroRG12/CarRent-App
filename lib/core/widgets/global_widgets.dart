import 'package:flutter/material.dart';

Widget inputFieldWidget(
    {required String labelText,
    Color? colorText,
    IconData? icon,
    TextInputType? textType,
    TextEditingController? controller,
    bool? obscureText}) {
  return TextField(
    decoration: InputDecoration(
      labelText: labelText,
      contentPadding: const EdgeInsets.symmetric(vertical: 20),
      labelStyle: TextStyle(color: colorText),
      prefixIcon: Icon(icon),
      prefixIconColor: colorText,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(18),
        ),
      ),
    ),
    //si no se intruduce un valor, mostrar un mensaje
    controller: controller,
    obscureText: obscureText ?? false,
    keyboardType: textType,
  );
}

notificationPop(BuildContext context, message, Color color) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      // Elimina 'const' aquí
      content: Text(message),
      backgroundColor: color,
    ),
  );
}
