import 'package:expressmatchrace/menu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_web_browser/flutter_web_browser.dart';
class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
    int _rating = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children:[
                 Container(
                    height: MediaQuery.of(context).size.height,
                    color: Color.fromARGB(121, 0, 0, 0)),
                 Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                   Padding(
                     padding: const EdgeInsets.only(top:40.0),
                     child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: (){
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>Menu()));
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: const Color(0xff30393D),
                                    borderRadius: BorderRadius.circular(50)),
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                             Text(
                              "REVIEWS",
                              style:  GoogleFonts.inter(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Opacity(opacity: 0, child: Text("Reviews"))
                          ],
                        ),
                      ),
                   ),
                   Column(
                    children: [
                      
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                           child:  Text(
                      "Leave your feedback about the app.",
                      style:  GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                    ),
                         ),
                       ),
                    
                    Container(
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(
                        border: Border.all(width: 3, color: Color(0xffFFCF49)),
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xbfF2B200),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:  TextField(
                          style:  GoogleFonts.inter(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400),
                           maxLines: null,
                           expands: true,
                            decoration: const InputDecoration(
                               border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                              fillColor: Colors.white,
                              
                        )),
                      ),
                    )
                    ,Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                IconButton(
                  icon: (_rating >= 1 ? Icon(Icons.star) : Icon(Icons.star_border)),
                  color: Color(0xffF2B200),
                            iconSize: 50,
                  onPressed: () {
                    setState(() {
                      _rating = 1;
                    });
                  },
                ),
                IconButton(
                  icon: (_rating >= 2 ? Icon(Icons.star) : Icon(Icons.star_border)),
                 color: Color(0xffF2B200),
                           iconSize: 50,
                  onPressed: () {
                    setState(() {
                      _rating = 2;
                    });
                  },
                ),
                IconButton(
                  icon: (_rating >= 3 ? Icon(Icons.star) : Icon(Icons.star_border)),
                 color: Color(0xffF2B200),
                           iconSize: 50,
                  onPressed: () {
                    setState(() {
                      _rating = 3;
                    });
                  },
                ),
                IconButton(
                  icon: (_rating >= 4 ? Icon(Icons.star) : Icon(Icons.star_border)),
                  color: Color(0xffF2B200),
                            iconSize: 50,
                  onPressed: () {
                    setState(() {
                      _rating = 4;
                    });
                  },
                ),
                IconButton(
                  icon: (_rating >= 5 ? Icon(Icons.star) : Icon(Icons.star_border)),
                  color: Color(0xffF2B200),
                  iconSize: 50,
                  onPressed: () {
                    setState(() {
                      _rating = 5;
                    });
                  },
                ),
                      ],
              ),
               ClipRRect(
                      borderRadius: BorderRadius.circular(40.0),
                      child: Container(
                        height: 65,
                        width: MediaQuery.of(context).size.width / 1.7,
                        decoration: const BoxDecoration(
                          color: Color(0xFF30393D),
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 3,
                            ),
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Menu()));
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Color(0xFF30393D),
                          ),
                          child:  Text(
                            "Send",
                            style:  GoogleFonts.inter(fontSize: 22,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                      ClipRRect(
                      borderRadius: BorderRadius.circular(40.0),
                      child: Container(
                        height: 65,
                        width: MediaQuery.of(context).size.width / 1.7,
                        decoration: const BoxDecoration(
                          color: Color(0xFF30393D),
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 3,
                            ),
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () async{
                            final url = 'https://pages.flycricket.io/express-match-race/privacy.html';
                               await FlutterWebBrowser.openWebPage(url: url);
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Color(0xFF30393D),
                          ),
                          child:  Text(
                            "Privacy Policy",
                            style:  GoogleFonts.inter(fontSize: 22,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 100,)
                    ],
                   )
                  ],
                ),
              ),]
            ),
          ),
        ));
  }
}
