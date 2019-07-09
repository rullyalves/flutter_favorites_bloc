import 'package:json_annotation/json_annotation.dart';

part 'Post.g.dart';

// flutter packages pub run build_runner build

@JsonSerializable()
class Post {
  int userId;
  int id;
  String title;
  String body;

  Post();

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);

  bool operator ==(other) => other is Post && other.id == id;

  @override
  int get hashCode =>
      super.hashCode ^ userId.hashCode * title.hashCode ^ body.hashCode;
}
