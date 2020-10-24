import 'package:empty_fridge/presentation/listProduct/ListProductBloc.dart';
import 'package:empty_fridge/presentation/listProduct/ListProductScreen.dart';
import 'package:empty_fridge/presentation/productSelection/bloc/ProductSelection.dart';
import 'package:empty_fridge/presentation/productSelection/screens/ProductSelectionScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:provider/provider.dart';

void main() {
  Stetho.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ProductSelectionBloc>(
          create: (_) => ProductSelectionBloc(),
          dispose: (_, ProductSelectionBloc productSelectBloc) => productSelectBloc.dispose(),
        ),
        Provider<ListProductBloc>(
          create: (_) => ListProductBloc(),
          dispose: (_, ListProductBloc listProductBloc) => listProductBloc.dispose(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: ProductSelectionScreen.id,
        routes: <String, WidgetBuilder>{
          ProductSelectionScreen.id: (BuildContext context) => ProductSelectionScreen(),
          ListProductScreen.id: (BuildContext context) => ListProductScreen(),
        },
      ),
    );
  }
}
