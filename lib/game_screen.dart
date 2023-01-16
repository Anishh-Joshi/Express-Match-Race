import 'dart:convert';
import 'dart:math';
import 'package:expressmatchrace/dataset.dart';
import 'package:expressmatchrace/dialog.dart';
import 'package:expressmatchrace/doubleConverter.dart';
import 'package:expressmatchrace/layout.dart';
import 'package:expressmatchrace/match_card.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameScreen extends StatefulWidget {
  final double gameScore;

  const GameScreen({super.key, this.gameScore = 0});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  List gameStats = [];
  int team1Seed = Random().nextInt(31) + 0;
  int team2Seed = Random().nextInt(31) + 0;
  double? bestScore;
  int interval = 2;
  double _arrowPosition = 180;
  Map _container1Country = {};
  Map _container2Country = {};
  double _score = 1;
  double _containerPosition = 0;
  AnimationController? _animationController;
  double _containerValue1 = Random().nextDouble() * (7 - 1.5) + 1.5;
  double _containerValue2 = Random().nextDouble() * (7 - 1.5) + 1.5;
  double _containerValue3 = Random().nextDouble() * (7 - 1.5) + 1.5;
  bool _container1IsBomb = false;
  bool _container2IsBomb = false;
  bool _container3IsBomb = false;
  int _chances = 3;
  int _speed = 1000;
  bool _isContainer1Touched = false;
  bool _isContainer2Touched = false;
  bool _isContainer3Touched = false;
  bool disableSwipe = false;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> saveStats() async {
    final SharedPreferences prefs = await _prefs;
    List<dynamic> flatList = gameStats.expand((i) => i).toList();
    final jsonString = jsonEncode(flatList);
    // set the value in SharedPreferences
    prefs.setString('myList', jsonString);
  }

  void generateRecord(double container1, double container2, double container3,
      Map country1, Map country2) {
    if (_container1IsBomb && _container2IsBomb) {
      gameStats.add([country2['country']]);
    } else if (_container3IsBomb && _container2IsBomb) {
      gameStats.add([country1['country']]);
    }
  }

  void vibrate() {
    HapticFeedback.mediumImpact();
  }

  void determineBomb() {
    int seed = Random().nextInt(3) + 1;
    if (seed == 1) {
      _container1IsBomb = false;
      _container2IsBomb = true;
      _container3IsBomb = true;
    } else if (seed == 2) {
      _container1IsBomb = true;
      _container2IsBomb = false;
      _container3IsBomb = true;
    } else if (seed == 3) {
      _container1IsBomb = true;
      _container2IsBomb = true;
      _container3IsBomb = false;
    }
  }

  determineSpeedOfTheGame() {
    if (_speed >= 900) {
      _speed = _speed - 50;
    } else {
      _speed = _speed - 14;
    }
  }

  @override
  void initState() {
    bestScore = widget.gameScore;
    _container1Country = Team[
        team1Seed == team2Seed && team1Seed != 31 ? team1Seed + 1 : team1Seed];
    _container2Country = Team[team2Seed];
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _speed),
    );
    determineBomb();
    _animationController!.forward();
    _animationController!.addListener(() {
      setState(() {
        _containerPosition =
            _animationController!.value * MediaQuery.of(context).size.height;
        if (_arrowPosition >= 0 &&
            _arrowPosition <= (MediaQuery.of(context).size.width / 3) &&
            _containerPosition + (MediaQuery.of(context).size.height / 5) >=
                MediaQuery.of(context).size.height &&
            !_isContainer1Touched &&
            !disableSwipe) {
          if (_container1IsBomb) {
            setState(() {
              _chances = _chances - 1;
            });
          }
          _container1IsBomb ? null : _score *= _containerValue1;
          _container1IsBomb ? null : vibrate();
          generateRecord(_containerValue1, 0, _containerValue3,
              _container1Country, _container2Country);
          disableSwipe = true;
          _isContainer1Touched = true;
        }
        if (_arrowPosition > (MediaQuery.of(context).size.width / 3) &&
            _arrowPosition <= (2 * MediaQuery.of(context).size.width / 3) &&
            _containerPosition + (MediaQuery.of(context).size.height / 5) >=
                MediaQuery.of(context).size.height &&
            !_isContainer2Touched &&
            !disableSwipe) {
          if (_container2IsBomb) {
            setState(() {
              _chances = _chances - 1;
            });
          }
          _container2IsBomb ? null : _score *= _containerValue2;
          _container2IsBomb ? null : vibrate();
          generateRecord(_containerValue1, 0, _containerValue3,
              _container1Country, _container2Country);
          disableSwipe = true;
          _isContainer2Touched = true;
        }
        if (_arrowPosition > (2 * MediaQuery.of(context).size.width / 3) &&
            _containerPosition + (MediaQuery.of(context).size.height / 5) >=
                MediaQuery.of(context).size.height &&
            !_isContainer3Touched &&
            !disableSwipe) {
          if (_container3IsBomb) {
            setState(() {
              _chances = _chances - 1;
            });
          }
          _container3IsBomb ? null : _score *= _containerValue3;
          _container3IsBomb ? null : vibrate();
          generateRecord(_containerValue1, 0, _containerValue3,
              _container1Country, _container2Country);
          disableSwipe = true;
          _isContainer3Touched = true;
        }
        if (_chances == 0) {
          saveStats();
          if (_score > bestScore!) {
            bestScore = _score;
          }
          _animationController!.stop();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return DialogCustom(
                  convert: convert, bestScore: bestScore!, score: _score);
            },
          );
        }
      });
    });
    _animationController!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        interval -= 1;
        determineSpeedOfTheGame();
        _animationController!.reset();
        _animationController!.duration =
            Duration(milliseconds: _speed > 100 ? _speed : 100);
        _animationController!.forward(from: 0.0);
        disableSwipe = false;
        team1Seed = Random().nextInt(31) + 0;
        team2Seed = Random().nextInt(31) + 0;
        _container1Country = Team[team1Seed == team2Seed && team1Seed != 31
            ? team1Seed + 1
            : team1Seed];
        _container2Country = Team[team2Seed];
        _containerPosition = 0;
        _containerValue1 = Random().nextDouble() * (7 - 1.5) + 1.5;
        _containerValue2 = Random().nextDouble() * (7 - 1.5) + 1.5;
        _containerValue3 = Random().nextDouble() * (7 - 1.5) + 1.5;
        determineBomb();
        _isContainer1Touched = false;
        _isContainer2Touched = false;
        _isContainer3Touched = false;
      }
    });
    super.initState();
  }

  DoubleConverter convert = DoubleConverter();
  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned(child: Layout()),
          Positioned(
            top: 0,
            child: Container(
              margin: const EdgeInsets.only(top: 80),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xffF2B200),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "x${convert.convertDouble(_score).toString()}",
                      style: GoogleFonts.inter(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: _containerPosition,
            left: 0,
            right: 0,
            child: Row(
              children: [
                _isContainer1Touched
                    ? Expanded(child: Container())
                    : MatchCard(
                        draw: false,
                        countryFlag: _container1Country['img'],
                        containerValue: _containerValue1,
                        isBomb: _container1IsBomb,
                        winText: "WIN 1",
                        mainColor: true,
                        teamName: _container1Country['country'],
                        borderColor: Color(0xffFFCF49),
                      ),
                _isContainer2Touched
                    ? Expanded(child: Container())
                    : MatchCard(
                        draw: true,
                        countryFlag: _container1Country['img'],
                        containerValue: _containerValue2,
                        winText: "DRAW",
                        mainColor: false,
                        isBomb: _container2IsBomb,
                        teamName: "",
                        borderColor: Color(0xff71D741),
                      ),
                _isContainer3Touched
                    ? Expanded(child: Container())
                    : MatchCard(
                        draw: false,
                        isBomb: _container3IsBomb,
                        countryFlag: _container2Country['img'],
                        containerValue: _containerValue3,
                        winText: "WIN 2",
                        mainColor: true,
                        teamName: _container2Country['country'],
                        borderColor: Color(0xffFFCF49),
                      ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            left: _arrowPosition,
            child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    _arrowPosition += details.delta.dx;
                    if (_arrowPosition >= 0 &&
                        _arrowPosition <=
                            (MediaQuery.of(context).size.width / 3) &&
                        _containerPosition +
                                (MediaQuery.of(context).size.height / 5) >=
                            MediaQuery.of(context).size.height &&
                        !_isContainer1Touched &&
                        !disableSwipe) {
                      _container1IsBomb ? null : _score *= _containerValue1;
                      _container1IsBomb ? null : vibrate();
                      _isContainer1Touched = true;
                      disableSwipe = true;
                    }
                    if (_arrowPosition >
                            (MediaQuery.of(context).size.width / 3) &&
                        _arrowPosition <=
                            (2 * MediaQuery.of(context).size.width / 3) &&
                        _containerPosition +
                                (MediaQuery.of(context).size.height / 5) >=
                            MediaQuery.of(context).size.height &&
                        !_isContainer2Touched &&
                        !disableSwipe) {
                      _container2IsBomb ? null : _score *= _containerValue2;
                      _container2IsBomb ? null : vibrate();
                      _isContainer2Touched = true;
                      disableSwipe = true;
                    }
                    if (_arrowPosition >
                            (2 * MediaQuery.of(context).size.width / 3) &&
                        _containerPosition +
                                (MediaQuery.of(context).size.height / 5) >=
                            MediaQuery.of(context).size.height &&
                        !_isContainer3Touched &&
                        !disableSwipe) {
                      _container3IsBomb ? null : _score *= _containerValue3;
                      _container3IsBomb ? null : vibrate();
                      _isContainer3Touched = true;
                      disableSwipe = true;
                    }
                  });
                },
                child: Image.asset('assets/arrow.png')),
          ),
        ],
      ),
    );
  }
}
