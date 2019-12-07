import 'package:catflip/models/cat.dart';
import 'package:catflip/services/cat_api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritesView extends StatefulWidget {
  @override
  _FavouritesViewState createState() => _FavouritesViewState();
}

class _FavouritesViewState extends State<FavouritesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Favourites'),
      ),
      body: _getItems(),
    );
  }

  Widget _getItems() {
    final catApi = Provider.of<CatApiService>(context, listen: false);

    return FutureBuilder<List<Cat>>(
      future: catApi.getFavourites(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length == 0) {
            return Center(child: Text('No favourites...'));
          }

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, i) {
              var cat = snapshot.data[i];
              return Container(
                padding: EdgeInsets.all(5),
                height: 300,
                alignment: Alignment.center,
                child: Image.network(
                  cat.url,
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('${snapshot.error}'));
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
