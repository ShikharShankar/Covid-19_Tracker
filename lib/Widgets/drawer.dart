import 'package:covid_tracker/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/painting.dart';

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width * 0.8, 0);
    path.quadraticBezierTo(
        280, size.height * 0.6, size.width * 0.8, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

Drawer buildDrawer(context, widget) {
  return Drawer(
    child: Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
            child: Image.asset(
              "assets/covid_black.png",
              width: 160,
            ),
          ),
          Column(
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.home,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "HomePage",
                      style: TextStyle(fontSize: yMargin(2.5)),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.flag,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Countries",
                      style: TextStyle(fontSize: yMargin(2.5)),
                    )
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      "assets/icons/india.svg",
                      height: yMargin(4.5),
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Indian States",
                      style: TextStyle(
                        fontSize: yMargin(2.5),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: <Widget>[
                      SvgPicture.asset(
                        "assets/icons/virus.svg",
                        height: yMargin(3.3),
                        color: Colors.black,
                      ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "About Covid-19",
                      style: TextStyle(fontSize: yMargin(1)),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.refresh,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Refresh Data",
                      style: TextStyle(fontSize: yMargin(2.5)),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  showAboutDialog(
                      context: context,
                      applicationIcon: SvgPicture.asset(
                        "assets/icons/virus.svg",
                        height: 40,
                      ),
                      applicationName: "Covid Tracker\n",
                      applicationLegalese:
                          "This app tracks number of cases of corona across your Location and other countries worldwide.");
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.info,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "About",
                      style: TextStyle(fontSize: yMargin(2.5)),
                    )
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 4),
                child: Text(
                  "Covid Tracker",
                  style: TextStyle(
                      fontFamily: "Kayak", fontSize: 16, color: Colors.teal),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                width: 2,
                height: 25,
                color: Colors.grey,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "© Shikhar Shankar",
                style: TextStyle(fontFamily: "Kayak", fontSize: 14),
              )
            ],
          )
        ],
      ),
    ),
  );
}
