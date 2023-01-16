import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchCard extends StatelessWidget {
  final double containerValue;
  final Color borderColor;
  final String winText;
  final String teamName;
  final String countryFlag;
  final bool draw;
  final bool  mainColor;
  final bool isBomb;

  const MatchCard({required this.isBomb, super.key,required this.countryFlag, required this.draw, required this.containerValue, required this.borderColor, required this.winText, required this.teamName, required this.mainColor});

  @override
  Widget build(BuildContext context) {
    return  Container(
                    height: (MediaQuery.of(context).size.height / 4.5),
                    width: (MediaQuery.of(context).size.width / 3),
                    decoration: BoxDecoration(
                      color:  Color(0xbf2F2F2F),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            child:  draw? Center(child: Text("X",style:  GoogleFonts.inter( fontWeight:FontWeight.bold, fontSize: 50,color: Colors.white),)):Column(
                              
                              children: [
                                 Padding(
                                  padding:  EdgeInsets.all(8.0),
                                  child: Text(teamName,style:   GoogleFonts.inter(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                                ),
                          Expanded(child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom:8.0),
                              child: Image.asset(countryFlag,fit: BoxFit.contain,height: 20,),
                            ))),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            color:  const Color(0xff222222),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(winText,style:   GoogleFonts.inter(color: Colors.white,fontSize: 20,fontWeight: FontWeight.normal),),
                                ),
                                Container(
                                 
                                  decoration: BoxDecoration(
                                     color: isBomb?Color(0xbfF2B200):Color(0xbf71D741),
                                     border: Border.all(color:  isBomb?Color(0xbfF2B200):Color(0xbf71D741),width: 2)),

                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("x "+containerValue.toStringAsFixed(2),style:   GoogleFonts.inter(color: Colors.white,fontSize: 20,fontWeight: FontWeight.normal)),
                                  )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
  }
}