import 'package:flutter_favorites_bloc/models/Post.dart';

class Favorites {

  final _postList = <Post>{};

  Set<Post> get posts => _postList;

  void addPost(Post post) => _postList.add(post);

  void deletePost(Post post) => _postList.remove(post);

}
