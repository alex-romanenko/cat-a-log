import 'package:catflip/providers/theme_changer.dart';
import 'package:catflip/services/cat_api_service.dart';
import 'package:catflip/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      Provider<CatApiService>(
        create: (context) => CatApiService(),
        dispose: (context, value) => value.dispose(),
      ),
      ChangeNotifierProvider<ThemeChanger>(
        create: (context) => ThemeChanger.defaultTheme(),
      ),
    ], child: ThemedApp());
  }
}

class ThemedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeChanger = Provider.of<ThemeChanger>(context);

    return MaterialApp(
      title: 'Cat Viewer 9000',
      theme: themeChanger.getTheme(),
      home: HomeView(),
    );
  }
}
