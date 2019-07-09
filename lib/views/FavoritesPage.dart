import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_favorites_bloc/blocs/FavoriteBloc.dart';
import 'package:flutter_favorites_bloc/models/Post.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {





  @override
  Widget build(BuildContext context) {
    FavoriteBloc favoriteBloc = BlocProvider.of<FavoriteBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("página de favoritos"),
      ),
      body: Container(
        child: StreamBuilder(
          stream: favoriteBloc.favoritesListFlux,
          builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
            if (snapshot.hasData && snapshot.data.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  Post post = snapshot.data[index];
                  return Dismissible(
                    onDismissed: (direction) {
                      favoriteBloc.favoritesDeleteEvent.add(post);
                    },
                    child: Card(
                      child: Container(
                        height: 200,
                        width: 200,
                        color: Colors.blueGrey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("postId: ${post.id}"),
                            Text("postTitle: ${post.title}"),
                            Text("postBody : ${post.body}")
                          ],
                        ),
                      ),
                    ),
                    key: Key("${post.id}"),
                  );
                },
              );
            } else {
              return Center(
                child: Text("Você ainda não possui favoritos"),
              );
            }
          },
        ),
      ),
    );
  }
}
