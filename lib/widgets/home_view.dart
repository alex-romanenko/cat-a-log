import 'package:catflip/models/cat.dart';
import 'package:catflip/services/cat_api_service.dart';
import 'package:catflip/widgets/cat_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<List<Cat>> _futureCats;
  List<Cat> _loadedCats = List<Cat>();
  CatApiService _catApi;
  int _page = 0;

  @override
  void didChangeDependencies() {
    _catApi = Provider.of<CatApiService>(context);
    _futureCats = _catApi.fetchCats();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cat Viewer 9000'),
        ),
        body: FutureBuilder<List<Cat>>(
          future: _futureCats,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data.length > 0) {
              _loadedCats = snapshot.data;
              return _buildItemList();
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return Center(child: CircularProgressIndicator());
          },
        ));
  }

  Widget _buildItemList() {
    return ListView.builder(
      itemCount: _loadedCats.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, i) {
        var cat = _loadedCats[i];

        return CatItem(
          key: ValueKey(cat.id),
          catImage: Image.network(
            cat.url,
          ),
          onItemDismissed: (direction) {
            setState(() {
              _loadedCats.removeAt(i);
              if (_loadedCats.length == 0) {
                fetchCats();
              }
            });

            // Show a snackbar. This snackbar could also contain "Undo" actions.
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(direction.toString())));
          },
        );
      },
    );
  }

  void fetchCats() {
    _futureCats = _catApi.fetchCats(page: _page);
    _page++;
  }
}
