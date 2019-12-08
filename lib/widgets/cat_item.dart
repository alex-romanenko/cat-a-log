import 'package:flutter/material.dart';

typedef void OnDismissedCallback(DismissDirection direction);

class CatItem extends StatelessWidget {
  const CatItem({@required this.key, this.onItemDismissed, this.catImage})
      : super(key: key);

  final Key key;
  final OnDismissedCallback onItemDismissed;
  final Image catImage;

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);

    return Dismissible(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('assets/images/cats.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        width: media.size.width,
        height: media.size.height,
        alignment: Alignment.center,
        child: catImage,
      ),
      background: Container(
        padding: EdgeInsets.only(left: 25),
        alignment: Alignment.centerLeft,
        child: _buildLeaveBehindIcon(Icons.check, 'Yay'),
        color: Colors.green,
      ),
      secondaryBackground: Container(
        padding: EdgeInsets.only(right: 25),
        alignment: Alignment.centerRight,
        child: _buildLeaveBehindIcon(Icons.cancel, 'Nay'),
        color: Colors.red,
      ),
      key: key,
      onDismissed: onItemDismissed,
    );
  }

  Widget _buildLeaveBehindIcon(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon),
        SizedBox(
          height: 5,
        ),
        Text(label),
      ],
    );
  }
}
