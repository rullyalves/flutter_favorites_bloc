import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_favorites_bloc/blocs/FavoriteBloc.dart';
import 'package:flutter_favorites_bloc/blocs/FavoriteCardBloc.dart';
import 'package:flutter_favorites_bloc/models/Post.dart';
import 'dart:async';
class PostCard extends StatefulWidget {
  final Post post;
  PostCard(this.post);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  FavoriteCardBloc _favoriteCardBloc;
  FavoriteBloc _favoriteBloc;

  StreamSubscription _streamSubscription;

  @override
  void initState() {
    _favoriteCardBloc = FavoriteCardBloc(widget.post);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _favoriteBloc = BlocProvider.of<FavoriteBloc>(context);

      _favoriteBloc.favoritesListFlux
          .listen(_favoriteCardBloc.favoritesListEvent.add);
    });
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    _favoriteCardBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey,
      child: Container(
          margin: const EdgeInsets.all(10),
          width: 200,
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 10),
                child: Text(
                  "postId:${widget.post.id}",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 10),
                child: Text(
                  "postTitle: ${widget.post.title}",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Text(
                "postBody: ${widget.post.body}",
                style: TextStyle(color: Colors.white),
              ),
              StreamBuilder(
                stream: _favoriteCardBloc.isFavoriteFlux,
                initialData: false,
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  return snapshot.data
                      ? IconButton(
                          icon: Icon(Icons.favorite, color: Colors.red),
                          onPressed: () {
                            _favoriteBloc.favoritesDeleteEvent.add(widget.post);
                          },
                        )
                      : IconButton(
                          icon: Icon(
                            Icons.favorite_border,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            _favoriteBloc.favoritesAddEvent.add(widget.post);
                          },
                        );
                },
              ),
            ],
          )),
    );
  }
}
