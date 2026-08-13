import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/product_provider.dart';
import 'product_detail.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),

      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          if (productProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: productProvider.products.length,
            itemBuilder: (context,index){
              final product = productProvider.products[index];

              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailPage(product: product,
                  ),
                  ),
                  );
                },

                child: Card(
                  child: ListTile(
                    title: Text(product["title"]),
                    subtitle: Text(product["description"]),
                    trailing: Text("\$${product["price"]}"),
                  ),
                ),
              );

            });
        },
      ),




    //  body: products.isEmpty ? const Center(child: CircularProgressIndicator(),) : ListView.builder(
    //   itemCount:products.length,
    //   itemBuilder: (context, index){
    //     return GestureDetector(
    //       onTap:() {
    //         Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailPage(
    //           product:products[index],
    //         ),
    //         ),
    //         );
           
    //       },

    //       child: Card(
    //         child: ListTile(
    //           title: Text(products[index]["title"]),
    //           subtitle: Text(products[index]["description"]),
    //           trailing: Text('\$${products[index]["price"]}'),
    //         ),
    //       ),

    //     );
    //   }
    //  ),

    );
  }
}