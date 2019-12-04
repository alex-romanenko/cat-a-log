import 'package:flutter/material.dart';

typedef void OnDismissedCallback(DismissDirection direction);

class CatItem extends StatelessWidget {
  const CatItem({this.key, this.onItemDismissed}) : super(key: key);

  final Key key;
  final onItemDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      child: ListTile(
        title: Text('Some Name'),
      ),
      background: Container(
        color: Colors.green,
      ),
      secondaryBackground: Container(
        color: Colors.red,
      ),
      key: key,
      onDismissed: onItemDismissed,
    );
  }
}
