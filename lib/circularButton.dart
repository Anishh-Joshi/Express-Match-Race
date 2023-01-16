import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCircularButton extends StatelessWidget {
  final String title;
  final VoidCallback action;
  final String icoPath;
  const CustomCircularButton({super.key, required this.icoPath, required this.title, required this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
    width: 70,
    height: 70,
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
                Color(0xff30393D),
                Color(0xff2D3031),
            ],
        ),
        borderRadius: BorderRadius.circular(100.0),
        boxShadow: [
            BoxShadow(
                color: Color(0xff202223),
                offset: Offset(0, 10),
                blurRadius: 6,
            ),
        ],
    ),
    child: Material(
        color: Colors.transparent,
        child: InkWell(
            child: Center(
                child: Image.asset(icoPath)
            ),
            onTap: action,
        ),
    ),
    );
  }
}