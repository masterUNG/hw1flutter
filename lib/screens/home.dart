import 'package:flutter/material.dart';
import 'package:homevdo/screens/register.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //decralation variable
  double mySizeLogo = 120;
  Color myColor = Color(0xFF003c8F);

  //methods
  Widget showLogo() {
    return Container(
      width: mySizeLogo,
      height: mySizeLogo,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showAppName() {
    return Text(
      'ท่องเที่ยวทั่วโลก',
      style: TextStyle(
        fontSize: 30,
        color: myColor,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        fontFamily: 'Itim',
      ),
    );
  }

  Widget showButton() {
    return Container(
      width: 250,
      child: Row(
        children: <Widget>[
          signInButton(),
          mySizeBox(),
          signUpButton(),
        ],
      ),
    );
  }

  Widget signInButton() {
    return Expanded(
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: myColor,
        child: Text(
          'Sign In',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget signUpButton() {
    return Expanded(
      child: OutlineButton(
        borderSide: BorderSide(
          color: myColor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'Sign Up',
          style: TextStyle(
            color: myColor,
          ),
        ),
        onPressed: () {
          MaterialPageRoute materialPageRoute =
              MaterialPageRoute(builder: (BuildContext context) => Register());
          Navigator.of(context).push(materialPageRoute);
        },
      ),
    );
  }

  Widget mySizeBox() {
    return SizedBox(
      width: 8,
      height: 16,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Colors.white,
                Colors.grey[400],
              ],
              radius: 0.7,
            ),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              showLogo(),
              showAppName(),
              mySizeBox(),
              showButton(),
            ],
          ),
        ),
      ),
    );
  }
}
