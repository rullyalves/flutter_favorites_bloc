import 'package:flutter_favorites_bloc/models/Post.dart';
import 'package:flutter_favorites_bloc/services/PostService.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class PostBloc extends BlocBase {
  final _postApi = PostService();

  final _postListController = BehaviorSubject<List<Post>>();
  Observable<List<Post>> get postListFlux => _postListController.stream;
  Sink<List<Post>> get postListEvent => _postListController.sink;

  PostBloc() {
    _postApi.getPosts().then(postListEvent.add);
  }

  @override
  void dispose() {
    _postListController.close();
  }
}
