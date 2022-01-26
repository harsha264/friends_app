import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:friends_app/database/database.dart';
import 'package:friends_app/models/user.dart';
import 'package:friends_app/view/login.dart';

class Register extends StatefulWidget{
  const Register({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController? txCont;

  String? firstName;
  String? lastName;
  String? emailId;
  String? mobileNumber;
  String? password;

  addUser() async{
    await DatabaseHelper.instance.addUser(
      User(
        firstName: firstName,
        lastName: lastName,
        emailId: emailId,
        mobileNumber: mobileNumber,
        password: password
      ),
    );

    setState(() {
      txCont?.clear();
      showInSnackBar('User created successfully!');
      startTime();
    });
  }

  startTime() async {
    var _duration = const Duration(seconds: 2);
    return Timer(_duration, navigate);
  }

  void navigate(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const Login()));
  }

  void showInSnackBar(String value) {
    // ignore: deprecated_member_use
     _scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600
          ),
          textAlign: TextAlign.center
        ),
        backgroundColor: Colors.green,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ListView(
        children: [
          Center(
            child: SvgPicture.asset('assets/friends_icon.svg',height: 200),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Register',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 22
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Please enter the details here',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                    fontSize: 15
                  ),
                ),
              ],
            )
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left:10, right:10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(),
                  ),
                  child: TextFormField(
                    controller: txCont,
                    onChanged: (v){
                      setState(() {
                        firstName = v;
                      });
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Firstname',
                      hintStyle: TextStyle(
                        color: Colors.grey
                      )
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(left:10, right:10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(),
                  ),
                  child: TextFormField(
                    controller: txCont,
                    onChanged: (v){
                      setState(() {
                        lastName = v;
                      });
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Lastname',
                      hintStyle: TextStyle(
                        color: Colors.grey
                      )
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(left:10, right:10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(),
                  ),
                  child: TextFormField(
                    controller: txCont,
                    onChanged: (v){
                      setState(() {
                        emailId = v;
                      });
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'EmailId',
                      hintStyle: TextStyle(
                        color: Colors.grey
                      )
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(left:10, right:10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(),
                  ),
                  child: TextFormField(
                    controller: txCont,
                    onChanged: (v){
                      setState(() {
                        mobileNumber = v;
                      });
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Mobile Number',
                      hintStyle: TextStyle(
                        color: Colors.grey
                      )
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(left:10, right:10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(),
                  ),
                  child: TextFormField(
                    controller: txCont,
                    onChanged: (v){
                      setState(() {
                        password = v;
                      });
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        color: Colors.grey
                      )
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: (){
                    addUser();
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    padding: const EdgeInsets.only(left:10, right:10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.transparent),
                      color: Colors.purple
                    ),
                    child: const Center(
                      child: Text('Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    )
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const Login()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: const TextSpan(
                        text: 'Go back to ',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500
                        ),
                        children: <TextSpan>[
                          TextSpan(text: 'Login', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.purple,decoration: TextDecoration.underline,)),
                        ],
                      ),
                    )
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}