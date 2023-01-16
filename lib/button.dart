import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback action;
  const CustomButton({super.key, required this.title, required this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
    width: MediaQuery.of(context).size.width/1.3,
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
        borderRadius: BorderRadius.circular(50.0),
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
                child: Text(
                    title,
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                    ),
                ),
            ),
            onTap: action,
        ),
    ),
    );
  }
}