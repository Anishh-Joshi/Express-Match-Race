import 'package:expressmatchrace/button.dart';
import 'package:expressmatchrace/circularButton.dart';
import 'package:expressmatchrace/feedback.dart';
import 'package:expressmatchrace/game_screen.dart';
import 'package:expressmatchrace/stats.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Menu extends StatefulWidget {


  @override
  State<Menu> createState() => _MenuState();
}




class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
           CustomButton(title: "GO EXPRESS", action: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=>GameScreen(gameScore: 0,)));}),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomCircularButton(action: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>FeedbackPage()));},title: "",icoPath: 'assets/bookmark.png',)
),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomCircularButton(action: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Statistics()));},title: "",icoPath: 'assets/stats.png',)
                    ),
              ],
            )
          ],
        ) /* add child content here */,
      ),
    );
  }
}
