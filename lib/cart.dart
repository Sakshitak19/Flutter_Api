import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("cart"),
      ),
      body: 
      Consumer<CartProvider>(
        builder: (context,cartProvider,child){


          if(cartProvider.isLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if(cartProvider.allProducts.isEmpty){
            return const Center(child: Text("Cart is empty"),
            );
          }

           return ListView.builder(
            itemCount: cartProvider.allProducts.length,
            itemBuilder: (context, index) {

              final product =
                  cartProvider.allProducts[index];

              return Card(
                margin: const EdgeInsets.all(10),

                child: ListTile(
                  leading: Image.network(
                    product["thumbnail"],
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),

                  title: Text(
                    product["title"],
                  ),

                  subtitle: Text(
                    "Quantity: ${product["quantity"]}",
                  ),

                  trailing: Text(
                    "\$${product["price"]}",
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}