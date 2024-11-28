import 'package:SocialMedia/model/user.dart';
import 'model/post.dart';
import 'requests.dart';
import 'dart:io';

void main() async {
  User? currentUser;
  while (true) {
    print('1: Login\n2: Signup\n3: Posts\n4: Add Post\n5: Chatroom\n6: Exit\n');
    print('Enter your option: ');
    final action = stdin.readLineSync();
    switch (action) {
      case '1':
        currentUser = await login();
        break;

      case '2':
        await signup();
        break;

      case '3':
        await getPosts();
        break;

      case '4':
        await addPost();
        break;

      case '5':
        await chatroom();
        break;

      default:
        return;
    }
  }
}

Future<User?> login() async {
  print('Enter your Username: ');
  final username = stdin.readLineSync();
  print('Enter your Password: ');
  final password = stdin.readLineSync();
  if (username == null || password == null) {
    print('Please add your username and pasword');
    return null;
  }
  final response = await Requests.login(username, password);
  if (response != null) {
    print('Login successful: $response');
  } else {
    print('Login failed.');
  }
  return response;
}

Future<void> signup() async {
  print('Enter your firstname: ');
  var firstname = stdin.readLineSync();
  print('Enter your lastname: ');
  var lastname = stdin.readLineSync();
  print('Enter your age: ');
  var age = int.tryParse(stdin.readLineSync() ?? '');
  print(
      'Hi $firstname $lastname, you are $age years old and age type is ${age.runtimeType}');

  var signupResult = await Requests.signup(firstname, lastname, age);
  print(signupResult['firstName']);
  print(signupResult['lastName']);
  print(signupResult['age']);
  print(signupResult['id']);
}

Future<void> getPosts() async {
  List<dynamic> posts = await Requests.getPosts();
  for (var post in posts) {
    print('Title: ${post.title}\nDescription: ${post.body}');
  }
}

Future<void> addPost() async {
  print('Enter title: ');
  var title = stdin.readLineSync();
  print('Enter body');
  var body = stdin.readLineSync();
  Post? newPost = await Requests.addPost(title, body);
  if (newPost == null) {
    print('Failed to create post');
  } else {
    print('The post title: ${newPost.title}');
    print('The post body: ${newPost.body}');
  }
}

chatroom() {}
