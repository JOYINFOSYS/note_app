import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class DataShowScreen extends StatelessWidget {
  const DataShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown.shade300,
        title: Text("Display data"),

      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("users").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if (snapshot.hasError) {
              return Center(child: const CircularProgressIndicator());
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: const CircularProgressIndicator());
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
                itemBuilder: (context,index){

                var doc = snapshot.data!.docs[index];

                return ListTile(

                  leading: IconButton(onPressed: (){
                    Clipboard.setData(ClipboardData(text: doc['userName']));
                  }, icon: Icon(Icons.copy),),

                  title: Text("Name : ${doc['userName']}"),
                  subtitle: Text("Age : ${doc['age']}"),

                  trailing: IconButton(onPressed: (){
                    Share.share('check out my website https://example.com');
                  }, icon: Icon(Icons.share)),
                );

            });
          },
            ),
    );
  }
}
