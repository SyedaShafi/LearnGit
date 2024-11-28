import 'package:SocialMedia/model/content.dart';

class Post {
  final String title;
  final String body;

  Post(this.title, this.body);

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(json['title'], json['body']);
  }
}

class Reel extends Content {
  Reel(super.id);
}
