import 'package:flutter/material.dart';

class IdolCard extends StatelessWidget {
  final String idolName;
  final String idolColor;

  const IdolCard({super.key, required this.idolName, required this.idolColor});

  @override
  Widget build(BuildContext context) {
    final red = int.parse(idolColor.substring(0, 2), radix: 16);
    final green = int.parse(idolColor.substring(2, 4), radix: 16);
    final blue = int.parse(idolColor.substring(4), radix: 16);
    return SizedBox(
        height: 60,
        child: Card(
          color: Color.fromARGB(255, red, green, blue),
          child: Center(child: Text(idolName)),
        ));
  }
}
