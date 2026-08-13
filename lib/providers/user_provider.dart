import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {

  Map<String,dynamic> user = {};
  bool isLoading = false;

  Future<void> getCurrentUser()async{
    isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("accessToken");

    if(accessToken==null){
      print("Token not found");
      isLoading=false;
      notifyListeners();
      return;
    }

    final response = await http.get(
      Uri.parse("https://dummyjson.com/user/me"),
      headers: {
        "Authorization": "Bearer $accessToken",
      },
    );

    if(response.statusCode==200){
       user = jsonDecode(response.body);
    }else{
      print("failed to get user");
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> updateUser() async{
    final response = await http.put(
       Uri.parse("https://dummyjson.com/users/2"),
       headers: {
        "Content-Type":"application/json",
       },
       body: jsonEncode({
        "firstName":"Sakshi",
        "lastName":"Tak"
       }),
       );

       if (response.statusCode==200){
        final data = jsonDecode(response.body);

        user={
          ...user,
          ...data,
        };

        notifyListeners();
        print("User Updated Successfully");


       }else{
        print("failed");
       }
  }

  Future<void> deleteUser()async{
    final response = await http.delete(Uri.parse("https://dummyjson.com/users/1"),
    );

    if(response.statusCode==200){
      user = {};

      final prefs = await SharedPreferences.getInstance();
      await prefs.remove("accessToken");
      notifyListeners();
    }else{
      print("failed");
    }
  }



}