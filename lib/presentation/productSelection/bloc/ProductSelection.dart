

import 'dart:async';

import 'package:empty_fridge/common/Bloc.dart';
import 'package:empty_fridge/entities/Product.dart';

class ProductSelectBloc implements Bloc{

  final _currentProductController = StreamController<Product>();
  var _curProduct = Product("Milk");


  Stream<Product> get currentProduct => _currentProductController.stream;

  @override
  void dispose() {
    _currentProductController.close();
  }



}