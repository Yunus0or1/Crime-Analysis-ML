import 'package:flutter/material.dart';

class NoInternetPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _NoInternetPageState();
}

class _NoInternetPageState extends State<NoInternetPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                buildLogo(),
                SizedBox(height: 30.0),
                noInternetTitle(),
                SizedBox(height: 10.0),
                noInternetButton(),
                SizedBox(height: 15.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLogo() {
    return Image.asset(
      'assets/images/logo.png',
      alignment: Alignment.center,
      fit: BoxFit.contain,
      // width: 128.0,
      height: 100.0,
    );
  }

  Widget noInternetTitle() {
    return Center(
      child: Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
          child: Text(
            "No internet connection or server is down.",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.red, fontWeight: FontWeight.w500, fontSize: 18),
          ),
        ),
      ),
    );
  }

  Widget noInternetButton() {
    return Center(
      child: Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
          child: MaterialButton(
            minWidth: 200.0,
            height: 35,
            color: Colors.black,
            child: new Text('Retry',
                style: new TextStyle(fontSize: 16.0, color: Colors.white)),
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/', (Route<dynamic> route) => false);
            },
          ),
        ),
      ),
    );
  }
}
