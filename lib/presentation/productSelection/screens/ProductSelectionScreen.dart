import 'package:empty_fridge/components/ProductCard.dart';
import 'package:empty_fridge/components/RoundedButton.dart';
import 'package:empty_fridge/entities/Product.dart';
import 'package:empty_fridge/presentation/productSelection/bloc/ProductSelection.dart';
import 'package:empty_fridge/presentation/productSelection/bloc/ProductSelectionAction.dart';
import 'package:empty_fridge/presentation/productSelection/screens/AboutScreen.dart';
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
          child: Padding(
              padding: EdgeInsets.fromLTRB(0.0, 32.0, 0, 8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          child: IconButton(
                            icon: Icon(Icons.info_outline),
                            tooltip: 'Info',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AboutScreen()),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Consumer<ProductSelectionBloc>(builder: (context, _productSelectionBloc, child) {
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
                    }),
                    RoundedButton(color: Colors.lightGreen, title: 'Finish selection', onPressed: () {}),
                  ]))),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.green,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.add,
              color: Colors.white,
            ),
            Text(
              " Add",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 24.0,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Skip",
              style: TextStyle(
                color: Colors.white,
                // fontWeight: FontWeight.w700,
                fontSize: 24.0,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 30,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  Widget _getCard(Product product, Function(ProductSelectionAction) handle) {
    return Dismissible(
      key: UniqueKey(),
      background: slideLeftBackground(),
      secondaryBackground: slideRightBackground(),
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
      // child: ListTile(title: Text('${product.name}')),
      child: ProductCard(
        title: product.name,
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.width / 2,
//                    * _animation.value,
      ),
    );
  }
}
