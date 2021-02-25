import 'package:get/get.dart';
import 'package:prac_flutter/api-provider.dart';
import 'package:prac_flutter/post-model.dart';

class APIController extends FullLifeCycleController {

  final id;
  var posts = List<Post>().obs;
  var isFetching = true.obs;


  APIController(this.id);

  @override
  void onInit() async {
    await fetchData();
    super.onInit();
  }
  

  
  Future<void> fetchData() async {
    print(" ========= fetchData with ID: $id =======");
    PostProvider provider = new PostProvider();
    var fetched = await provider.getPost();
    posts.assignAll(fetched);
    isFetching(false);
  }

}