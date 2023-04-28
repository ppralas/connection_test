import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET('/posts')
  Future<List<Post>> getPosts();

  @POST('/posts')
  Future<Post> createPost(@Body() Map<String, dynamic> postData);

  @PUT('/posts/{postId}')
  Future<Post> putPost(
      @Path('postId') int postId, @Body() Map<String, dynamic> postData);

  @PATCH('/posts/{postId}')
  Future<Post> patchPost(
      @Path('postId') int postId, @Body() Map<String, dynamic> postData);

  @DELETE('/posts/{postId}')
  Future<void> deletePost(@Path('postId') int postId);
}

class Post {
  int userId;
  int id;
  String title;
  String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        body: json['body'],
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'id': id,
        'title': title,
        'body': body,
      };

  @override
  String toString() => toJson().toString();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Post &&
          runtimeType == other.runtimeType &&
          toJson().toString() == other.toJson().toString();

  @override
  int get hashCode => toJson().toString().hashCode;
}
