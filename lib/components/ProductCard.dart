import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  ProductCard({this.title, this.width, this.height });

  final String title;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 5.0,
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(MediaQuery.of(context).size.width / 20),
        child: Container(
          width:  width,
          height: height,
          child: Center(
            child: Text(
              title,
              key: Key('counterKey'),
              style: TextStyle(fontSize: 24.0),
            ),
          ),
        ),
      ),
    );
  }
}
