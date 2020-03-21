import 'package:empty_fridge/presentation/productSelection/bloc/ProductSelection.dart';
import 'package:empty_fridge/presentation/productSelection/screens/ProductSelectionScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() => runApp(MyApp());

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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: ProductSelectionScreen.id,
        routes: <String, WidgetBuilder>{
          ProductSelectionScreen.id: (BuildContext context) => ProductSelectionScreen(),
        },
      ),
    );
  }
}


