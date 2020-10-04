
import 'Product.dart';

class ProductListItem{
  int id;
  Product product;
  bool isPurchased;

  ProductListItem(this.id, this.product, this.isPurchased);

  ProductListItem productFromMap(Map inMap) {

    bool isPurchased = false;
    if(inMap["isPurchased"] == "1"){
      isPurchased = true;
    }

    ProductListItem result = ProductListItem(inMap["id"], Product(inMap["name"]), isPurchased);
    return result;
  }
  Map<String, dynamic> noteToMap(ProductListItem item) {
    Map<String, dynamic> map = Map<String, dynamic>();
    map["id"] = item.id;
    map["title"] = item.product.name;
    map ["isPurchased"] = item.isPurchased ? 1 : 0;
    return map;
  }



}