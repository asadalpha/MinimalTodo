import 'package:flutter/material.dart';

Widget categorySelect(String txt, Color color) {
  return Chip(
    label: Text(txt),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    labelPadding: const EdgeInsets.all(10),
  );
}
