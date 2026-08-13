import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CartProvider extends ChangeNotifier{
  List allProducts=[];

  bool isLoading = false;

  Future<void> getCart() async{
    isLoading = true;
    notifyListeners();

    final response = await http.get(Uri.parse("https://dummyjson.com/carts"),
    );

    if(response.statusCode==200){
      final data = jsonDecode(response.body);
      List carts = data["carts"];

      allProducts.clear();

      for(var cart in carts){
        allProducts.addAll(cart["products"]);
      }

    }

    isLoading = false;
    notifyListeners();
  }
    
   Future<bool> addTocart({
    required int productId,
      required int quantity,
    }) async {

      final response = await http.post(Uri.parse("https://dummyjson.com/carts/add"),
      headers:{
        'Content-Type':"application/json",
      },
      body:jsonEncode({
        "userId":1,
        "products":[
          {
            "id":productId,
            "quantity":quantity,
          }
        ]
      }),
      );

      print("staus code:${response.statusCode}");
      print("Response: ${response.body}");

      if(response.statusCode==201){
        return true;
      }else{
        return false;
      }
   
    

  }


}
