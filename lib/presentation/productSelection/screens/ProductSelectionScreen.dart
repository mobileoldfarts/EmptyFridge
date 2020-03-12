import 'package:empty_fridge/components/ProductCard.dart';
import 'package:flutter/material.dart';

class ProductSelectionScreen extends StatefulWidget {
  ProductSelectionScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProductSelectionScreenState createState() => _ProductSelectionScreenState();
}

class _ProductSelectionScreenState extends State<ProductSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//
//        title: Text(widget.title),
//      ),
      body: Container(
        color: Color(0xFF3D9098),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width / 1.2,
            height: MediaQuery.of(context).size.width / 2,
            child: Dismissible(
                key: UniqueKey(),
                onDismissed: (DismissDirection direction) {
                  if (direction == DismissDirection.endToStart) {
//                  _swipesBloc.incrementCounter.add(1);
                    setState(() {
//                    _controller.value = 0.5;
//                    _controller.forward();
                    });
                  } else {
//                  _swipesBloc.incrementCounter.add(-1);
                    setState(() {
//                    _controller.value = 0.5;
//                    _controller.forward();
                    });
                  }
                },
                child: ProductCard(
                  title: "Milk",
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: MediaQuery.of(context).size.width / 2,
//                    * _animation.value,
                )),
          ),
        ),
      ),
    );
  }
}