import 'package:expressmatchrace/button.dart';
import 'package:expressmatchrace/doubleConverter.dart';
import 'package:expressmatchrace/menu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'game_screen.dart';

class DialogCustom extends StatelessWidget {

  const DialogCustom({super.key, required this.bestScore, required this.score, required this.convert});
  final double bestScore;
  final double score;

 final  DoubleConverter? convert;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
                backgroundColor: Colors.transparent,
                body: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "EXPRESS IS OVER",
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Best result: ${convert!.convertDouble(bestScore).toString()}",
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                     
                        child: Center(
                          child: Container(
                               decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xffF2B200),
                        ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "x ${convert!.convertDouble(score).toString()}",
                                style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                          title: "Again",
                          action: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GameScreen(
                                          gameScore: bestScore,
                                        )));
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                          title: "Menu",
                          action: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (context) => Menu()),
                                (Route<dynamic> route) => false);
                          })
                    ],
                  ),
                ),
              );;
  }
}