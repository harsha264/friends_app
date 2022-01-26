import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:friends_app/database/database.dart';
import 'package:friends_app/view/homescreen.dart';
import 'package:friends_app/view/register.dart';

class Login extends StatefulWidget{
  const Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? mobileNumber;
  String? password;

  checkLogin(mobileNumber, password) async{
    var users = await DatabaseHelper.instance.getUsers(mobileNumber,password);
    if(users.isNotEmpty){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const HomeScreen()));
    }else{
      showInSnackBar('Invalid Credentials');
    }
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
        backgroundColor: Colors.red,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SvgPicture.asset('assets/friends_icon.svg'),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Login',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 22
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Please sign in to continue',
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
                  height: 100,
                ),
                GestureDetector(
                  onTap: (){
                    checkLogin(mobileNumber,password);
                  },
                  child: Container(
                    height: 50,
                    width: 100,
                    padding: const EdgeInsets.only(left:10, right:10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.transparent),
                      color: Colors.purple
                    ),
                    child: const Center(
                      child: Text('LOGIN',
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
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const Register()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: const TextSpan(
                        text: 'Don\'t have an account? ',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500
                        ),
                        children: <TextSpan>[
                          TextSpan(text: 'SignUp', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.purple,decoration: TextDecoration.underline,)),
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