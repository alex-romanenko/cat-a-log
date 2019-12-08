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

          return GridView.builder(
            itemCount: snapshot.data.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            padding: const EdgeInsets.all(5),
            itemBuilder: (context, i) {
              var cat = snapshot.data[i];

              return _buildGridTile(cat);
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('${snapshot.error}'));
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildGridTile(Cat cat) {
    return GridTile(
        child: Image.network(
          cat.url,
          fit: BoxFit.cover,
        ),
        header: GridTileBar(
          //backgroundColor: Colors.black38,
          title: SizedBox(),
          trailing: GestureDetector(
            child: Icon(
              Icons.star,
              color: Colors.yellowAccent,
            ),
            onTap: () {
              final catApi = Provider.of<CatApiService>(context);
              final response = catApi.removeFavourite(cat.id);

              response.then((result) {
                if (result) {
                  // TODO: show success
                } else {
                  // TODO: show error
                }
              });

              // // Show a snackbar. This snackbar could also contain "Undo" actions.
              // Scaffold.of(context).showSnackBar(
              //     SnackBar(content: Text('Item removed from favourites')));
            },
          ),
        ));
  }
}
