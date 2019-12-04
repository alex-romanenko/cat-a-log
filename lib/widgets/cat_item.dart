import 'package:flutter/material.dart';

typedef void OnDismissedCallback(DismissDirection direction);

class CatItem extends StatelessWidget {
  const CatItem({@required this.key, this.onItemDismissed, this.catImage})
      : super(key: key);

  final Key key;
  final onItemDismissed;
  final Image catImage;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      child: ListTile(
        title: catImage,
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
