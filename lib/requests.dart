import 'dart:convert';
import 'package:SocialMedia/model/user.dart';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'model/post.dart';

class Requests {
  static getPosts() async {
    try {
      var response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
      List<dynamic> json = jsonDecode(response.body);
      print(json);
      List<dynamic> posts = [];
      for (var obj in json) {
        final post = Post.fromJson(obj);
        posts.add(post);
      }
      return posts;
    } catch (e) {
      print('Error $e');
      return [];
    }
  }

  static getPost() async {
    try {
      var response = await http.get(Uri.parse("${Config.baseURLPost}/1"));
      Map<String, dynamic> json = jsonDecode(response.body);
      Post post = Post(json['title'], json['body']);
      return post;
    } catch (e) {
      print('Error');
      return [];
    }
  }

  static addPost(String? title, String? body) async {
    try {
      var response = await http.post(Uri.parse("${Config.baseURLPost}/add"),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'title': title,
            'body': body,
            'userId': 5,
          }));
      Map<String, dynamic> json = jsonDecode(response.body);
      Post post = Post(json['title'], json['body']);
      return post;
    } catch (e) {
      print('Error');
      return null;
    }
  }

  static signup(String? firstname, String? lastname, int? age) async {
    try {
      var response = await http.post(Uri.parse('${Config.baseURLUser}/add'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'firstName': firstname,
            'lastName': lastname,
            'age': age,
          }));
      return jsonDecode(response.body);
    } catch (e) {
      print('Error');
      return [];
    }
  }

  static login(String? username, String? password) async {
    try {
      var response = await http.post(Uri.parse('${Config.baseURLUser}/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'username': username,
            'password': password,
          }));
      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        print('Failed to log in: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error');
      return null;
    }
  }
}
