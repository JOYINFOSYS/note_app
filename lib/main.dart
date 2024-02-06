import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:note_app/data_show_screen.dart';


main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note App',
      theme: ThemeData(
       colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown.shade100,
        title: Text("Note App"),

      ),
      body: Center(

          child: Column(

            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(onPressed: (){

      firestore.collection("users").doc("01").set({

        "userName":"joy1",
        "age":"12",

      })
          .then((value) => print("Data added."))
          .catchError((error) => print("Failed to add user: $error"));
    }, child: const Text("Set Data")),


              ElevatedButton(onPressed: (){
                firestore.collection("users").add({

                  "userName":"Jsp",
                  "age":"22",

                })
                    .then((value) => print("Data added."))
                    .catchError((error) => print("Failed to add user: $error"));
              },
                  child: const Text('Add Data')),

              ElevatedButton(onPressed: (){

                Navigator.push(context, MaterialPageRoute(builder: (context)=>DataShowScreen()));
              },
                  child: const Text('Show Data')),
            ],
          )),
    );
  }
}
