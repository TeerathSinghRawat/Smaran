import 'package:alzheimersapporig/Screens/Patient/AboutCurrentCaretakerScreen.dart';
import 'package:alzheimersapporig/Utils/firebasehelper.dart';
import 'package:alzheimersapporig/models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CurrentCaretakerScreen extends StatefulWidget {
  final UserModel userModel;
  const CurrentCaretakerScreen({Key? key, required this.userModel})
      : super(key: key);

  @override
  State<CurrentCaretakerScreen> createState() => _CurrentCaretakerScreenState();
}

class _CurrentCaretakerScreenState extends State<CurrentCaretakerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Current Caretaker"),
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("PCrelationReverse")
              .doc(widget.userModel.uid)
              .collection("Caretaker list")
              .where("status", isEqualTo: "Active")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                QuerySnapshot querySnapshot = snapshot.data as QuerySnapshot;
                var list = querySnapshot.docs;
                // DocumentSnapshot documentSnapshot=snapshot.data as DocumentSnapshot;
                return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return FutureBuilder(
                          future:
                          FirebaseHelper.getusermodelbyid(list[index].id),
                          builder: (context, userdata) {
                            if (userdata.connectionState ==
                                ConnectionState.done) {
                              if (userdata.data != null) {
                                UserModel targetUser =
                                userdata.data as UserModel;
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AboutCurrentCaretakerScreen(
                                                    userModel: targetUser)));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border:
                                        Border.all(color: Colors.black38),
                                      ),
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 5,),
                                          CircleAvatar(
                                            radius: 50,
                                            backgroundImage: NetworkImage(
                                                targetUser.profilepic
                                                    .toString()),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(targetUser.name.toString()),

                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            } else {
                              return Container();
                            }
                          });
                    });
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return const Center(
                  child: Text("No Active Patients"),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
