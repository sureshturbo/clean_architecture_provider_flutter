import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_app/Provider/ProductProvider/get_provider.dart';

class Products_List extends StatefulWidget {
  const Products_List({Key? key}) : super(key: key);

  @override
  State<Products_List> createState() => _Products_ListState();
}

class _Products_ListState extends State<Products_List> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //
    Future.delayed(Duration.zero, () {
      Provider.of<ProductProvider>(context, listen: false).FetchProducts();
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('product list'),),

      body: Consumer<ProductProvider>(
        builder: (context,productProvider, child ){
            if(productProvider.isLoading){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
            } else {
              if (productProvider.products.isEmpty) {
                return Center(
                  child: Text('No products available.'),
                );
              } else {
                return ListView.builder(
                  itemCount: productProvider.products.length,
                  itemBuilder: (context, index) {
                    if (index == productProvider.products.length - 1) {
                      // Load the next page when reaching the end
                      productProvider.loadNextPage();
                    }
                    final product = productProvider.products[index];
                    return ListTile(
                      title: Text(product.name),
                      subtitle: Text(product.description),
                      // Add more details or UI components as needed
                    );
                  },
                );
              }
            }
        },
      ),
    );
  }
}
