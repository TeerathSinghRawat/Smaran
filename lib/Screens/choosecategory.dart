import 'package:alzheimersapporig/Screens/loginpage.dart';
import 'package:flutter/material.dart';

class ChooseCategory extends StatefulWidget {
  const ChooseCategory({Key? key}) : super(key: key);

  @override
  State<ChooseCategory> createState() => _ChooseCategoryState();
}

class _ChooseCategoryState extends State<ChooseCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Choose your category ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 45,
                    fontFamily: "Domine"
                  ),
                ),
                const SizedBox(height: 60,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return const LoginPage(category: "Patient",);
                      }));
                    },
                        child: const Text("Patient")
                    ),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return const LoginPage(category: "caretaker",);
                      }));
                    },
                        child: const Text("Caretaker")
                    )
                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
