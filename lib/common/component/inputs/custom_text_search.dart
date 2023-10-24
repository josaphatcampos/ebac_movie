import 'package:flutter/material.dart';

class CustomTextSearch extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String placeholder;
  final bool isObscured;
  final Function function;

  const CustomTextSearch(
      {super.key,
      required this.controller,
      required this.label,
      required this.placeholder,
      this.isObscured = false, required this.function});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isObscured,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.all(8),
        label: Text(label),
        hintText: placeholder,
        hintStyle: const TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(Icons.search),
          onPressed: (){
            function();
          },
        )
      ),
    );
  }
}
