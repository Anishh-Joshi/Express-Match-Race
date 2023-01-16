import 'dart:convert';
import 'package:expressmatchrace/dataset.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'menu.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  List winList = [];
  bool isLoading = false;
  Map<String, int> countries ={};

  @override
  void initState() {
    try{
      getListFromSharedPrefs();
    }catch(e){

    }
  }

  void getListFromSharedPrefs() async {
    setState(() {
      isLoading = true;
    });
    try {
      final prefs = await SharedPreferences.getInstance();

      // get the JSON string from SharedPreferences
      final jsonString = prefs.getString('myList');

      // convert the JSON string to a list
      final list = jsonDecode(jsonString!) as List;

      winList = list.map((item) => item.toString()).toList();
      countries = Map.fromIterable(winList,
          key: (e) => e, value: (e) => winList.where((x) => x == e).length);
      setState(() {
        isLoading = false;
      });
    } catch (e) {}
  }

  String getFlag(country) {
    String imgPath = Team.where((e) => e['country'] == country).first['img'];
    return imgPath;
  }

  @override
  Widget build(BuildContext context) {
    var keys = countries.keys.toList(); // convert the map keys to a list
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
          child:  Stack(children: [
                  Container(
                      height: MediaQuery.of(context).size.height,
                      color: Color.fromARGB(121, 0, 0, 0)),
                  Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 50.0, left: 8, right: 8),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Menu()));
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: const Color(0xff30393D),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: const Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "Statistics",
                                style: GoogleFonts.inter(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Opacity(opacity: 0, child: Text("Reviews"))
                            ],
                          ),
                        ),
                      ),
                      isLoading?Container():Container(
                        height: MediaQuery.of(context).size.height*0.88,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: countries.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Opacity(
                                      opacity: 0,
                                      child: Container(),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width / 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              keys[index].toString(),
                                              style: GoogleFonts.inter(
                                                  fontSize: 20,
                                                  decoration: TextDecoration.none,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Image.asset(
                                            getFlag(keys[index]),
                                            width: 120,
                                            fit: BoxFit.cover,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.white,
                                              width: 4,
                                            ),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 30.0),
                                          child: Text(
                                            countries[keys[index]].toString(),
                                            style: GoogleFonts.inter(
                                                fontSize: 50,
                                                decoration: TextDecoration.none,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                    Opacity(
                                      opacity: 0,
                                      child: Container(),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ]),
        ),
      ),
    );
  }
}
