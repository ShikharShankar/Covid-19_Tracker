import 'package:flutter/material.dart';
import 'package:covid_tracker/Screens/prevention_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:covid_tracker/constants.dart';

class PreventionCard extends StatelessWidget {
  //const PreventionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Expanded(child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => PreventionScreen(),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: xMargin(5),
          vertical: yMargin(2.5),
        ),
        width: double.infinity,
        child: Stack(
          alignment: Alignment.topLeft,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                left: xMargin(33),
                top: yMargin(2),
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFE0E0E0),Color(0xFF66BB6A)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Prevention',
                    style: TextStyle(
                      fontSize: yMargin(3),
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: yMargin(1),
                  ),
                  Text(
                    'Keep Yourself & Others Safe !!',
                    style: TextStyle(
                      fontFamily: "Kayak",
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: yMargin(1),
              left: xMargin(5),
              child: SvgPicture.asset(
                "assets/icons/nurse.svg",
                height: yMargin(12),
              ),
            ),
            Positioned(top: yMargin(1),
            left: xMargin(5),
              child: SvgPicture.asset(
                  "assets/icons/hand-wash.svg",
                height: yMargin(3.5),
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}
