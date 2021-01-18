import 'package:flutter/material.dart';

class Offers extends StatelessWidget {
  final planetThumbnail = Container(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    alignment: FractionalOffset.centerLeft,
    child: Image.asset("assets/images/google.png"),
    height: 92.0,
    width: 92.0,
  );

  final planetCard = InkWell(
    onTap: () {
      print("Clicked offer");
    },
    child: Container(
      margin: EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 10.0),
      constraints: BoxConstraints.expand(),
      child: Container(
        margin: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 4.0),
            Text(
              "Amazon AWS",
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            ),
            new Container(height: 10.0),
            new Text("Cloud Support Associate"),
            new Container(
                margin: new EdgeInsets.symmetric(vertical: 8.0),
                height: 2.0,
                width: 18.0,
                color: new Color(0xff00c6ff)),
            new Row(
              children: <Widget>[
                Icon(
                  Icons.access_alarm,
                  size: 14.0,
                ),
                new Container(width: 8.0),
                new Text("12/01/21"),
                new Container(width: 24.0),
                Icon(
                  Icons.score,
                  size: 14.0,
                ),
                new Container(width: 8.0),
                new Text("8.5"),
              ],
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        // color: new Color(0xFF333366),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        // boxShadow: <BoxShadow>[
        //   new BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 10.0,
        //     offset: new Offset(0.0, 10.0),
        //   ),
        // ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Stack(
        children: [planetCard, planetThumbnail],
      ),
    );
  }
}
