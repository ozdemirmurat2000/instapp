import 'package:flutter/material.dart';

class CardModelDefault {
  String baslik;
  String baslikAciklama;
  IconData leftIcon;
  Widget? widget;

  CardModelDefault(
      {required this.baslik,
      required this.baslikAciklama,
      required this.leftIcon,
      this.widget});
}
