import 'package:empty_fridge/components/ProductCard.dart';
import 'package:empty_fridge/entities/Product.dart';
import 'package:empty_fridge/presentation/productSelection/bloc/ProductSelection.dart';
import 'package:empty_fridge/presentation/productSelection/bloc/ProductSelectionAction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductSelectionScreen extends StatefulWidget {
  static String id = 'ProductSelectionScreen';

  ProductSelectionScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProductSelectionScreenState createState() => _ProductSelectionScreenState();
}

class _ProductSelectionScreenState extends State<ProductSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Color(0xFF3D9098),
          child: Consumer<ProductSelectionBloc>(builder: (context, _productSelectionBloc, child) {
            return StreamBuilder<Product>(
              initialData: Product(""),
              stream: _productSelectionBloc.currentProduct,
              builder: (context, snapshot) {
                var product = snapshot.data;

                if (product != null) {
                  return _getCard(product, _productSelectionBloc.handleEvent);
                }

                return CircularProgressIndicator();
              },
            );
          })),
    );
  }

  Widget _getCard(Product product, Function(ProductSelectionAction) handle) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.width / 2,
        child: Dismissible(
            key: UniqueKey(),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.endToStart) {
                handle(ProductSelectionAction.skip);
//                          setState(() {
//                    _controller.value = 0.5;
//                    _controller.forward();
//                          });
              } else {
                handle(ProductSelectionAction.add);
//                          setState(() {
//                    _controller.value = 0.5;
//                    _controller.forward();
//                          });
              }
            },
            child: ProductCard(
              title: product.name,
              width: MediaQuery.of(context).size.width / 1.2,
              height: MediaQuery.of(context).size.width / 2,
//                    * _animation.value,
            )),
      ),
    );
  }
}
