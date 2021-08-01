import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:covid_tracker/constants.dart';

class WidgetCard extends StatelessWidget {
  final String srcAsset;
  final String title;

  const WidgetCard({Key? key,required this.srcAsset,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SvgPicture.asset(srcAsset,height: yMargin(8),),
        Text(title,
          style: TextStyle(
            color: Colors.blue,
            fontFamily: "Titillium",
            fontSize: yMargin(2),),
          ),
      ],
    );
  }
}
