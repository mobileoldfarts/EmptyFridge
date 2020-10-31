import 'package:empty_fridge/entities/ProductListItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'ListProductBloc.dart';

class ListProductScreen extends StatefulWidget {
  static String id = 'ListProductScreen';

  ListProductScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ListProductScreenState createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product list'),
        backgroundColor: Color(0xFF3D9098),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.done_all),
            tooltip: 'Done all',
            onPressed: () {
              Provider.of<ListProductBloc>(context, listen: false).doneAll();
              Navigator.pop(context);
              },
          )
        ],
      ),
      body: Consumer<ListProductBloc>(builder: (context, _bloc, child) {
        return StreamBuilder<List<ProductListItem>>(
          initialData: List(),
          stream: _bloc.listProduct,
          builder: (context, snapshot) {
            _bloc.loadList();
            var list = snapshot.data;

            if (list != null) {
              return _getList(list, _bloc.checkProduct);
            }

            return CircularProgressIndicator();
          },
        );
      }),
    );
  }

  _getList(List<ProductListItem> list, Function(int, bool) checked) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return CheckboxListTile(
          title: Text(list[index].product.name),
          onChanged: (bool value) {
            checked(list[index].id, value);
          },
          value: list[index].isPurchased,
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}
