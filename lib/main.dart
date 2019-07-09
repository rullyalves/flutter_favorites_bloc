import 'package:flutter/material.dart';
import 'package:flutter_favorites_bloc/blocs/FavoriteBloc.dart';
import 'package:flutter_favorites_bloc/views/PostPage.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: FavoriteBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: PostPage(),
      ),
    );
  }
}
