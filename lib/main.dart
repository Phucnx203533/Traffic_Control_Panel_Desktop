import 'dart:collection';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:media_kit/media_kit.dart';
import 'package:news_app_ui/api/loginApi.dart';
import 'package:news_app_ui/dummy_data/user.dart';
import 'package:news_app_ui/screen/login/widgets//auth_page.dart';
import 'package:news_app_ui/screen/main_tab_bar/main_tab_bar.dart';
import 'package:news_app_ui/utils/constants/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';


// const apiKey = 'AIzaSyAGEyO4ZN7gdrvuqY4Vd1SMMCUVmt6UDno';
// const projectId = 'aaaa-dbb41';
// const email = 'phuc202@gmail.com';
// const password = '123456';
final startup = false;
final User user = new User(name: "admin", dateOfBirth: DateTime.timestamp(), phoneNumber: "0123456789");
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Necessary initialization for package:media_kit.
  MediaKit.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginApi loginApi = new LoginApi();

    Future<bool> checkAccessToken() async {
      try{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? accessToken = prefs.getString('accessToken');
        String? refreshToken = prefs.getString("refreshToken");
        // print(accessToken.toString());
        // print(refreshToken);
        // return true;
        if(accessToken == null || JwtDecoder.isExpired(refreshToken.toString())){
          return false;
        }else{
          if(JwtDecoder.isExpired(accessToken)){
            Map<String,String> result = new HashMap();
            result = await loginApi.refreshToken(refreshToken);
            result.forEach((key, value) {
              prefs.setString(key, value);
            });
          }
          return true;
        }
      }catch(e){
        return false;
      }

    }
    // GetMaterialApp getXApp = GetMaterialApp(
    //   themeMode: ThemeMode.light,
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(
    //       primaryColor: AppColors.primaryColor
    //   ),
    //   // home: MainTabBar(),
    //   home:
    //   AuthPage(),
    //   // initialBinding: AppBinding(),
    // );
    //
    // return getXApp;
    return FutureBuilder<bool>(
      future: checkAccessToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Nếu đang chờ dữ liệu, hiển thị màn hình trống
          return Container();
        } else {
          // Nếu đã có dữ liệu, kiểm tra xem có Access Token hay không
          bool hasAccessToken = snapshot.data!;
          return GetMaterialApp(
            themeMode: ThemeMode.light,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primaryColor: AppColors.primaryColor),
            home: hasAccessToken ? MainTabBar(0) : AuthPage(),
            // home:AuthPage(),
            // initialBinding: AppBinding(),
          );
        }
      },
    );

  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
