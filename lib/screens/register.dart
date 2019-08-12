import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //Global Declaration
  Color textColor = Colors.blueGrey[700];
  final formKey = GlobalKey<FormState>();
  String name, email, password;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //method
  Widget registerButton() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      onPressed: () {
        print('Register Click!!');
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          print('name = $name, email = $email, password = $password');
          registerThread();
        }
      },
    );
  }

  Future<void> registerThread() async {
    await firebaseAuth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((response) {
      setupDisplayName();
    }).catchError((response) {
      print('response = ${response.toString()}');
    });
  }

  Future<void> setupDisplayName() async {
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    UserUpdateInfo userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    firebaseUser.updateProfile(userUpdateInfo);

    // สร้างหน้าแบบไม่มีถอยหลังกลับ
    // MaterialPageRoute materialPageRoute =
    //     MaterialPageRoute(builder: (BuildContext context) => MyService());
    // Navigator.of(context)
    //     .pushAndRemoveUntil(materialPageRoute, (Route<dynamic> route) => false);
  }

  Widget nameText() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Username',
        labelStyle: TextStyle(color: Colors.deepPurple[500]),
        helperText: 'Input username in English',
        helperStyle: TextStyle(color: Colors.deepPurple[500]),
        hintText: 'กรุณาใส่ username',
        icon: Icon(
          Icons.color_lens,
          size: 36,
          color: Colors.deepPurple[500],
        ),
      ),
      validator: (value) {
        value = value.trim();
        if (value.isEmpty) {
          return 'Please Fill name in the blank';
        }
        return null;
      },
      onSaved: (String value) {
        name = value;
      },
    );
  }

  Widget emailText() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'email',
        labelStyle: TextStyle(color: Colors.indigo[500]),
        helperText: 'Input email มากกว่า 6 ตัว',
        helperStyle: TextStyle(color: Colors.indigo[500]),
        hintText: 'กรุณาใส่ email',
        icon: Icon(
          Icons.email,
          size: 36,
          color: Colors.indigo[500],
        ),
      ),
      validator: (value) {
        if (!(value.contains('@') && value.contains('.'))) {
          return 'กรุณากรอก email';
        }
        return null;
      },
      onSaved: (String value) {
        email = value;
      },
    );
  }

  Widget passwordText() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(color: Colors.teal[500]),
        helperText: 'Input password มากกว่า 6 ตัว',
        helperStyle: TextStyle(color: Colors.teal[500]),
        hintText: 'กรุณาใส่ password',
        icon: Icon(
          Icons.question_answer,
          size: 36,
          color: Colors.teal[500],
        ),
      ),
      validator: (value) {
        if (value.length < 6) {
          return 'กรุณาใส่ password มากกว่า 6 ตัว';
        }
        return null;
      },
      onSaved: (String value) {
        password = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: textColor,
        title: Text('Register'),
        actions: <Widget>[
          registerButton(),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
          colors: [Colors.white, Colors.blueGrey[200]],
          radius: 1.5,
          center: Alignment.topCenter,
        )),
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: ListView(
              children: <Widget>[
                nameText(),
                emailText(),
                passwordText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
