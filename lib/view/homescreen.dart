import 'package:flutter/material.dart';
import 'package:friends_app/database/database.dart';
import 'package:friends_app/models/friends.dart';
import 'package:friends_app/view/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController? txCont;

  String editfriendFirstName = "";
  String editfriendLastName = "";
  String editfriendEmailId = "";
  String editfriendMobilenumber = "";

  int? id;
  String? friendFirstName;
  String? friendLastName;
  String? friendEmailId;
  String? friendMobilenumber;

  dynamic friendsList = [];

  @override
  void initState() {
    super.initState();
    getFriendsData();
  }

  addFriendToDB() async{
    await DatabaseHelper.instance.addFriend(
      Friend(
        firstName: friendFirstName,
        lastName: friendLastName,
        emailId: friendEmailId,
        mobileNumber: friendMobilenumber,
      ),
    );

    setState(() {
      txCont?.clear();
      Navigator.pop(context);
      getFriendsData();
    });
  }

  updateFriendToDB() async{
    var res = await DatabaseHelper.instance.updateFriend(
      Friend(
        firstName: friendFirstName,
        lastName: friendLastName,
        emailId: friendEmailId,
        mobileNumber: friendMobilenumber,
      ),
      id
    );

    print(res);

    setState(() {
      Navigator.pop(context);
      getFriendsData();
    });
  }

  getFriendsData() async{
    var friendsListLocal = await DatabaseHelper.instance.getFriends();
    if(friendsListLocal.isEmpty){
      setState(() {
        friendsList = [];
      });
    }else{
      setState(() {
        friendsList = friendsListLocal;
      });
    }
  }

  doEdit(String number){
    getFriendDetails(number);
  }

  getFriendDetails(String number) async{
    var friendsListLocal = await DatabaseHelper.instance.getFriendsDetails(number);
    if(friendsListLocal.isNotEmpty){
      setState(() {
        editfriendFirstName = friendsListLocal[0].firstName!;
        editfriendLastName = friendsListLocal[0].lastName!;
        editfriendEmailId = friendsListLocal[0].emailId!;
        editfriendMobilenumber = friendsListLocal[0].mobileNumber!;

        id = friendsListLocal[0].id!;
        friendFirstName = friendsListLocal[0].firstName!;
        friendLastName = friendsListLocal[0].lastName!;
        friendEmailId = friendsListLocal[0].emailId!;
        friendMobilenumber = friendsListLocal[0].mobileNumber!;
      });
      editFriendBottomSheet();
    }
  }

  doDelete(String number) async{
    await DatabaseHelper.instance.deleteFriend(number);
    getFriendsData();
  }

  editFriendBottomSheet(){
    showModalBottomSheet(
      isScrollControlled: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      context: context,
      builder: (builder) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top:10.0,bottom:10),
                    child: Text('Edit Friend Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800
                      ),
                    ),
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
                            initialValue: editfriendFirstName,
                            onChanged: (v){
                              setState(() {
                                friendFirstName = v;
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
                            initialValue: editfriendLastName,
                            onChanged: (v){
                              setState(() {
                                friendLastName = v;
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
                            initialValue: editfriendEmailId,
                            onChanged: (v){
                              setState(() {
                                friendEmailId = v;
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
                            initialValue: editfriendMobilenumber,
                            onChanged: (v){
                              setState(() {
                                friendMobilenumber = v;
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
                          height: 50,
                        ),
                        GestureDetector(
                          onTap: (){
                            updateFriendToDB();
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
                              child: Text('Update Friend',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                            )
                          ),
                        ),
                      ],
                    ),
                  )
                ]
              )
            );
          }
        );
      }
    );
  }

  addFriendBottomSheet(){
    showModalBottomSheet(
      isScrollControlled: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      context: context,
      builder: (builder) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top:10.0,bottom:10),
                    child: Text('Enter Friend Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800
                      ),
                    ),
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
                                friendFirstName = v;
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
                                friendLastName = v;
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
                                friendEmailId = v;
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
                                friendMobilenumber = v;
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
                          height: 50,
                        ),
                        GestureDetector(
                          onTap: (){
                            addFriendToDB();
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
                              child: Text('Add Friend',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                            )
                          ),
                        ),
                      ],
                    ),
                  )
                ]
              )
            );
          }
        );
      }
    );
  }

  _logOut() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("user", "loggedIn");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const Login()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              _logOut();
            },
            icon: const Icon(Icons.power_settings_new_sharp),
          ),
          title: const Text('Friends'),
          elevation: 0,
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: (){
                
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: friendsList.length == 0 ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            Center(
              child: 
              friendsList.length == 0 ?
              const Text('No Friends'):
              ListView(
                shrinkWrap: true,
                children: List.generate(friendsList.length, (index){
                  return Container(
                    padding: const EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height*0.065,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(friendsList[index].firstName),
                        Row(
                          children: [
                            IconButton(
                              onPressed: (){
                                doEdit(friendsList[index].mobileNumber);
                              },
                              icon: const Icon(Icons.edit),
                              color: Colors.grey,
                            ),
                            IconButton(
                              onPressed: (){
                                doDelete(friendsList[index].mobileNumber);
                              },
                              icon: const Icon(Icons.delete),
                              color: Colors.redAccent,
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              )
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            addFriendBottomSheet();
          },
          child: const Icon(Icons.person_add_alt),
        ),
      ),
    );
  }
}