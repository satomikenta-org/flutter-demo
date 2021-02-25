import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prac_flutter/api-controller.dart';
import 'auth-controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'), // homeを設定しないと '/' が自動でHomeとなる
      initialBinding: AuthBinding(),
      getPages: [
        GetPage(name: '/', page: () => MyHomePage(title: "Flutter Demo Home Page2"), middlewares: [MyMiddleware1()] ),
        GetPage(name: '/second', page: () => SecondPage(title: "Second Page",)),
        GetPage(name: '/api', page: () => APIPage()),
        GetPage(name: '/login', page: () => LoginPage())
      ],
      
    );
  }
}


class MyMiddleware1 implements GetMiddleware {
  @override
  int priority = 0;

  @override
  RouteSettings redirect(String route){
    // Auth Middleware
    AuthController ac = Get.find();
    print(" ======== isAuth?? ========= ${ac.isAuth()}");
    return ac.isAuth() ? null : RouteSettings(name: '/login');
  }

  @override
  Widget onPageBuilt(Widget page) { 
    print(" =========== onPageBuild !!! ===========");
    return page;
  }

  @override
  GetPage onPageCalled(GetPage page) => page;
  
  @override
  List<Bindings> onBindingsStart(List<Bindings> bindings) => bindings;

  @override
  GetPageBuilder onPageBuildStart(GetPageBuilder page) => page;

  @override
  void onPageDispose() {}
}


class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: 
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Login',
              ),
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {Get.toNamed('/');}, 
        child: Icon(Icons.add),
      ),
    );
  }
}
 

class MyHomePage extends StatelessWidget {
  final String title;
  MyHomePage({ this.title });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: 
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'counter app',
              ),
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {Get.toNamed('/second');}, // Get.offAllはStack全て削除してから、新規にMyHomePageを生成するので, initStateが走る
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}



class SecondPage extends StatelessWidget {

  final String title;

  SecondPage({ this.title });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {Get.toNamed('/api', arguments: 100);},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), 
    );
  }
}


class APIPage extends StatefulWidget {
  
  @override
  _APIPageState createState() => _APIPageState();
}

class _APIPageState extends State<APIPage> with WidgetsBindingObserver {


  final APIController controller = Get.put(APIController(Get.arguments));

  @override void initState() {
    WidgetsBinding.instance.addObserver(this);    
    super.initState();
  }

  @override void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(" =============== state ============ $state");
    print(" ======== Get.arguments in LifeCycle ========= ${Get.arguments}");
    switch(state) {
      case AppLifecycleState.resumed:
        controller.fetchData(); break;
      default: break;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(" ======== Get.arguments ========= ${Get.arguments}");
    return Scaffold(
      appBar: AppBar(
        title: Text("API Fetch Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Obx(() {
              if (controller.isFetching.value) return CircularProgressIndicator();
              return Text(controller.posts[0].title);
            })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {Get.toNamed('/');},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), 
    );
  }
}