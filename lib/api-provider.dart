import 'package:get/get.dart';

import 'post-model.dart';

class PostProvider extends GetConnect {
  // Get request
  Future<List<Post>> getPost() async {
    var resp = await get('https://jsonplaceholder.typicode.com/posts');
    return postFromJson(resp.bodyString);
  }
}