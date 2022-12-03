import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../entities/category.dart';
import '../entities/product.dart';

class ProductModel with ChangeNotifier {
  bool isLoading = true;
  final List<Product> _products = [];
  List<Category> _categories = [];
  List<Product> filteredProducts = [];
  List<Product> get getAllProductsList => filteredProducts;
  List<Category> get getAllCategoryList => _categories;

  String? selectedFilter;

  ProductModel() {
    loadInit();
  }

  loadInit() async {
    try {
      isLoading = true;
      var response = await Dio().get('https://api.storerestapi.com/products');
      if (response.statusCode == 200 && response.data['status'] == 200) {
        if (response.data['data'] != null &&
            response.data['data'].length != 0) {
          for (var product in response.data['data']) {
            _products.add(Product.fromJson(product));
          }
          filteredProducts = _products;
          getAllCategory();
          selectedFilter = null;
        }
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  filterByCategory(String? categoryId) {
    try {
      isLoading = true;
      if (categoryId == null) {
        filteredProducts = _products;
      } else {
        filteredProducts =
            _products.where((e) => e.category.id == categoryId).toList();
      }
      selectedFilter = categoryId;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  getAllCategory() {
    try {
      _categories.addAll(_products.map<Category>((e) => e.category));

      var idSet = <String>{};
      var distinct = <Category>[];
      for (var d in _categories) {
        if (idSet.add(d.id)) {
          distinct.add(d);
        }
      }
      _categories = distinct;
    } catch (e) {
      rethrow;
    }
  }

  toggleFavorite(Product p) {
    int index = _products.indexWhere((e) => e == p);
    _products[index].favorite = !_products[index].favorite;
    // Can implement API call here
    notifyListeners();
  }
}
