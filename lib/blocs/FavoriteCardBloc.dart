import 'package:flutter_favorites_bloc/models/Post.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class FavoriteCardBloc extends BlocBase {

  final _favoritesListController = BehaviorSubject<List<Post>>();
  Observable<List<Post>> get favoritesListFlux =>_favoritesListController.stream;
  Sink<List<Post>> get favoritesListEvent => _favoritesListController.sink;

  final _isFavoriteController = BehaviorSubject<bool>();
  Observable<bool> get isFavoriteFlux => _isFavoriteController.stream;
  Sink<bool> get isFavoriteEvent => _isFavoriteController.sink;

  FavoriteCardBloc(Post post){
    favoritesListFlux
    .map((dados) => dados.contains(post))
    .listen(isFavoriteEvent.add);

  }

  @override
  void dispose() {
    _isFavoriteController.close();
    _favoritesListController.close();
  }
}



class CounterBloc {
  // variável que irá receber o valor da stream transformada
  Observable<int> streamTransformada;

  final _counterController = BehaviorSubject<int>();
  Observable<int> get counterFlux =>_counterController.stream;
  Sink<int> get counterEvent => _counterController.sink;

/*
No Dart, os getters funcionam da mesma forma que funções, logo quando você
invoca a transformação de uma stream (como o método map) que lhe retorna um novo observable(stream)
ou seja, um novo objeto da classe observable(stream) e se esse getter abaixo for chamad dentro de um
StreamBuilder, o mesmo irá produzir o efeito colateral que foi citado anteriormente nesse post, já que irá retornar
um novo objeto da classe Observable(stream)

  Observable<int> get counterFlux => _counterController
    .stream
    .map((a) => a * 2);

*/


  CounterBloc(Post post){
    /* 
     Aqui temos o exemplo de como transformar uma stream, sempre que transformar uma stream
     atribua essa transformação a uma variável, assim, sempre que didUpdateWidget do StreamBuilder
     for executado, ele irá comprovar que o Observable(stream) é o mesmo objeto que foi passado antes
     do Widget ser reconstruído, logo não irá ter o mesmo problema que retrato anteriormente no Post
    
    */

    streamTransformada = _counterController
    .stream
    .map((a) => a * 2);
 
  }


  void dispose() {
   _counterController.close();
  }
}
