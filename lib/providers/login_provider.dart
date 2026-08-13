import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LoginProvider extends ChangeNotifier{
  bool isLoading = false;
  String message="";

  Future<bool> login(String username,String password) async {
     isLoading = true;
     message="";
     notifyListeners();

     final response = await http.post(Uri.parse("https://dummyjson.com/auth/login"),
     body: {
      "username":username,
      "password":password,
     },
     );

     if(response.statusCode==200){
      final data = jsonDecode(response.body);

      final token = data["accessToken"];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("accessToken", token);
      print(token);

      isLoading = false;
      notifyListeners();

      return true;
     }else{
      message = "Login failed";

      isLoading=false;
      notifyListeners();
      return false;
     }

  }

} 