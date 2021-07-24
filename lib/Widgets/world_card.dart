import 'package:flutter/material.dart';
//import 'package:covid_tracker/Screens/Coun';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:covid_tracker/constants.dart';

class WorldCard extends StatelessWidget {

  final widget;
  final cases;
  final deaths;
  const WorldCard({ Key? key, this.widget, this.cases, this.deaths})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Expanded(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: xMargin(5),
            vertical: yMargin(2),
          ),
          width: double.infinity,
          child: Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  left: xMargin(35),
                  right: yMargin(1.5),
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFF5F5F5), Color(0xFFE0E0E0)],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "WorldWide Scenario",
                      style: TextStyle(
                        fontSize: yMargin(2.5),
                        color: Colors.black.withOpacity(.5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: yMargin(1),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: xMargin(7)),
                      child: Text(
                        "Cases: $cases\nDeaths: $deaths",
                        style: TextStyle(
                            fontSize: yMargin(1.8),
                            fontFamily: "Kayak",
                            color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: yMargin(3),
                left: xMargin(5),
                child: SvgPicture.asset(
                  "assets/icons/globe.svg",
                  height: yMargin(13),
                ),
              ),
              Positioned(
                top: yMargin(7),
                right: xMargin(4.5),
                child: SvgPicture.asset(
                  "assets/icons/patient.svg",
                  height: yMargin(5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
