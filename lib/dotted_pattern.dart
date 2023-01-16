import 'package:flutter/material.dart';

class DotWidget extends StatelessWidget {
  final double totalWidth, dashWidth, emptyWidth, dashHeight;

  final Color dashColor;

  const DotWidget({
    this.totalWidth = 300,
    this.dashWidth = 10,
    this.emptyWidth = 5,
    this.dashHeight = 2,
    this.dashColor = Colors.black,
  });
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: List.generate(
          totalWidth ~/ (dashWidth + emptyWidth)-1,
          (_) => Expanded(
            child: Container(
              width: 3.5,
              color: Colors.white,
              margin:
                  EdgeInsets.only(top:10,),
                  child: Container(
                    height: 30,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
