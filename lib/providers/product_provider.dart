import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductProvider extends ChangeNotifier{
  List products = [];

  bool isLoading = false;

  Future<void> getProduct() async{
    isLoading = true;
    notifyListeners();

    final response = await http.get(
      Uri.parse("https://dummyjson.com/products"),
    );

    if(response.statusCode==200){
      final data = jsonDecode(response.body);

      products = data["products"];
    } else{
      print("failed to fetch products");

    }
    isLoading = false;
    notifyListeners();
  }
}

