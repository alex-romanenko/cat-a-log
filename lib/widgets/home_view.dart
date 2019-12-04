import 'package:catflip/widgets/cat_item.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catflip'),
      ),
      body: ListView.builder(itemBuilder: (context, i) {
        //TODO
        return CatItem(
          onItemDismissed: _handleItemDismissed,
        );
      }),
    );
  }

  void _handleItemDismissed(DismissDirection direction) {
    setState(() {
      //items.removeAt(i);
    });
  }
}
