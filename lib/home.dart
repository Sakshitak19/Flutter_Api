import 'package:api/splash.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: [
           Text('Welcome to the Home Page!',style: TextStyle(fontSize:24, fontWeight: FontWeight.bold),),

           ElevatedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SplashScreen()),
            );
           }, child: Text("Back"),
           ),


        ],
      ),
    );
  }
}