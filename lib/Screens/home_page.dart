import 'dart:developer';

import 'package:alzheimersapporig/Screens/Patient/PreviousCaretaker.dart';
import 'package:alzheimersapporig/Screens/Patient/currentCaretaker.dart';
import 'package:alzheimersapporig/Screens/Patient/medicalHistory.dart';
import 'package:alzheimersapporig/Screens/Patient/memories.dart';
import 'package:alzheimersapporig/Screens/Patient/patient%20profile.dart';
import 'package:alzheimersapporig/models/usermodel.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final UserModel userModel;
  const HomePage({Key? key, required this.userModel}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Home Page'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PatientProfile(myUser: widget.userModel)));
              },
              child: CircleAvatar(
                backgroundImage:
                    NetworkImage(widget.userModel.profilepic.toString()),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    'https://www.maxlifeinsurance.com/content/dam/corporate/images/Health%20Insurance%20Policy%20in%20India%201.png'))),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.15,
            ),
            ReusableContainer(
              text: "Memories",
              icon: Icons.memory_outlined,
              onpressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Memories(userModel: widget.userModel)));

              },
            ),
            ReusableContainer(
              text: "Way To Home",
              icon: Icons.home,
              onpressed: () {},
            ),
            ReusableContainer(
              text: "My Medical History",
              icon: Icons.medical_information,
              onpressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PatientMedicalHistoryPage(patientUid: widget.userModel.uid.toString())));
              },
            ),
            ReusableContainer(
              text: "Current Caretaker",
              icon: Icons.document_scanner,
              onpressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CurrentCaretakerScreen(userModel: widget.userModel,)));

              },
            ),
            ReusableContainer(
              text: "Previous Caretaker",
              icon: Icons.history,
              onpressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PreviousCaretakerScreen(userModel: widget.userModel,)));

              },
            ),
            ReusableContainer(
                text: "Emergency",
                icon: Icons.call,
                onpressed: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        icon: const Icon(
                          Icons.call,
                          color: Colors.green,
                        ),
                        title: const Text('Emergency'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Exit')),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Ambulance')),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('CareTaker'))
                        ],
                      );
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class ReusableContainer extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function()? onpressed;
  const ReusableContainer({
    super.key,
    required this.text,
    required this.icon,
    required this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        elevation: 5,
        onPressed: onpressed,
        child: Container(
            padding: const EdgeInsets.only(left: 10),
            height: 60,
            decoration: BoxDecoration(
                color: Colors.blueGrey[100],
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Colors.deepPurple,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
