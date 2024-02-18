import 'dart:convert';

import 'package:flutter/material.dart';

import '../../Constants/url.dart';
import '../../Model/get_products.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier{
  final ProductService _productService = ProductService();
  List<Product> _products = [];
  bool _isLoading = false;
  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  int _currentPage = 1;
  late List<dynamic> data;

  Future<void> FetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {

      final response = await _productService.fetchProducts(_currentPage);
      data = jsonDecode(response.body)['data'];

      if (data.isNotEmpty) {
        // Convert the data to a list of Product objects
        List<Product> newProducts = data.map((json) => Product.fromJson(json)).toList();

        // Add the new products to the existing list
        _products.addAll(newProducts);
      }
    } catch (e) {
      // Handle the exception (e.g., show error message)
      print('Error fetching products: $e');
    } finally {
      Future.microtask(() {
        _isLoading = false;
        notifyListeners();
      });
    }
  }
  void loadNextPage() {
    if(data.isEmpty){
      print('data is empty');
    }else {
      _currentPage++;
      FetchProducts();
    }
  }

}

class ProductService {
  Future<http.Response> fetchProducts(int page) async {

    var url = AppUrl.baseUrl + 'v2/productlist?page=$page';
    print(url);
    final response = await http.get(Uri.parse(url));
    print(response.body);

    if (response.statusCode == 200) {
      return response; // Return the entire response object
    } else {
      throw Exception('Failed to load products');
    }
  }
}

// Future<void> FetchProducts() async{
//   _isLoading = true;
//   notifyListeners();
//
//   try{
//     final response = await _productService.fetchProducts(_currentPage);
//     _products = response.map((json) => Product.fromJson(json)).toList();
//     _products.addAll(_products);
//   }catch (e) {
//     // Handle the exception (e.g., show error message)
//     print('Error fetching products: $e');
//   } finally {
//     Future.microtask(() {
//       _isLoading = false;
//       notifyListeners();
//     });
//   }
// }

// class ProductService{
//   Future<List<Map<String,dynamic>>> fetchProducts(int page) async{
//     final response = await http.get(Uri.parse(AppUrl.baseUrl + 'v2/productlist?page=$page'));
// print(response.body);
//     if(response.statusCode == 200){
//         final List<dynamic> data = jsonDecode(response.body)['data'];
//         print(data);
//
//         return List<Map<String, dynamic>>.from(data);
//     }else {
//       throw Exception('Failed to load products');
//     }
//   }
// }