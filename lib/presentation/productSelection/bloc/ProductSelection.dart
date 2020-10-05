import 'dart:async';

import 'package:empty_fridge/common/Bloc.dart';
import 'package:empty_fridge/data/db/ProductDBWorker.dart';
import 'package:empty_fridge/entities/Product.dart';
import 'package:empty_fridge/entities/ProductListItem.dart';

import 'ProductSelectionAction.dart';

class ProductSelectionBloc implements Bloc {
  List<Product> _listProduct = [
    Product("Milk"),
    Product("Bread "),
    Product("Eggs "),
    Product("Bananas "),
    Product("Beer"),
  ];

  Product get currProduct => _listProduct[_currPosition];
  final _currentProductController = StreamController<Product>();
  var _currPosition = 0;

  ProductSelectionBloc() {
    _currentProductController.sink.add(currProduct);
  }

  void handleEvent(ProductSelectionAction action) {
    _currPosition++;
    if (_currPosition >= _listProduct.length) {
      _currPosition = 0;
    }

    _currentProductController.sink.add(_listProduct[_currPosition]);

    switch (action) {
      case ProductSelectionAction.add:
        // TODO: Handle this case.
        ProductDBWorker.db.create(ProductListItem(-1, _listProduct[_currPosition], false));
        break;
      case ProductSelectionAction.skip:
        // TODO: Handle this case.
        break;
    }
  }

  Stream<Product> get currentProduct => _currentProductController.stream;

  @override
  void dispose() {
    _currentProductController.close();
  }
}
