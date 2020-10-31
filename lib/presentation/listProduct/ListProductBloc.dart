import 'dart:async';

import 'package:empty_fridge/common/Bloc.dart';
import 'package:empty_fridge/data/db/ProductDBWorker.dart';
import 'package:empty_fridge/entities/ProductListItem.dart';
import 'package:rxdart/rxdart.dart';

class ListProductBloc implements Bloc {
  var _listProduct = BehaviorSubject<List<ProductListItem>>();

  Stream<List<ProductListItem>> get listProduct => _listProduct.stream;

  ListProductBloc() {
    loadList();
  }

  @override
  void dispose() {
    _listProduct.close();
  }

  void loadList() async {
    _listProduct.sink.add(await ProductDBWorker.db.getAllProduct());
  }

  void checkProduct(int id, bool isChecked) async{

    ProductDBWorker.db.checkProduct(id, isChecked);
    loadList();

  }

  void doneAll() async {
    ProductDBWorker.db.deleteAll();
    loadList();
  }
}
