import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:friends_app/database/database.dart';
import 'package:friends_app/models/friends.dart';
import 'package:friends_app/view/login.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController? txCont;

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

  getFriendsData() async{
    var friendsListLocal = await DatabaseHelper.instance.getFriends();
    print(friendsListLocal);
    if(friendsListLocal == null){
      setState(() {
        friendsList = [];
      });
    }else{
      setState(() {
        friendsList = friendsListLocal;
      });
    }
  }

  doEdit(BuildContext context, String number) {}

  doDelete(BuildContext context, String number) {}

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const Login()));
          },
          icon: const Icon(Icons.power_settings_new_sharp),
        ),
        title: const Text('Friends'),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top:10,bottom:10),
            child: Text('Slide left to edit...'),
          ),
          Center(
            child: 
            friendsList.length == 0 ?
            const Text('No Friends'):
            ListView(
              shrinkWrap: true,
              children: List.generate(friendsList.length, (index){
                return Slidable(
                  key: const ValueKey(0),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    dismissible: DismissiblePane(onDismissed: () {}),
                    children: [
                      SlidableAction(
                        onPressed: doEdit(context,friendsList[index].mobileNumber),
                        backgroundColor: Colors.greenAccent,
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Edit',
                      ),
                      SlidableAction(
                        onPressed: doDelete(context,friendsList[index].mobileNumber),
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: ListTile(title: Text(friendsList[index].firstName)),
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
    );
  }
}