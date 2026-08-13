import 'package:api/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'splash.dart';
import 'providers/product_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/user_provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context)=>ProductProvider()..getProduct(),
      ),
      ChangeNotifierProvider(create: (context)=>
      CartProvider()..getCart(),
      ),
      ChangeNotifierProvider(create: (context)=>
      UserProvider()..getCurrentUser(),
      ),
      ChangeNotifierProvider(create: (context)=>LoginProvider(),
      ),
    ],
    child: const MyApp(),




    ),
  );
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});


@override
Widget build(BuildContext context){
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const SplashScreen(),
  );
}
}
