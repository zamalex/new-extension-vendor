//import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
//import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:extension_vendor/Providers/constants.dart';
import 'package:extension_vendor/Providers/orders_provider.dart';
import 'package:extension_vendor/Screens/appoinment/appointment_list.dart';
import 'package:extension_vendor/Screens/home_screen.dart';
import 'package:extension_vendor/Screens/vendor_login.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/Notification/NotificationList.dart';
import 'firebase_options.dart';




Future<void> main()  async {
  //await Firebase.initializeApp();

  WidgetsFlutterBinding.ensureInitialized();
  /*await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId("744e8b47-813d-4439-9bec-4534573ab0e8");

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });

  OneSignal.shared.setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {
    // Will be called whenever a notification is received in foreground
    // Display Notification, pass null param for not displaying the notification
    event.complete(event.notification);
  });

  OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
    // Will be called whenever a notification is opened/button pressed.
  });

  OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
    // Will be called whenever the permission changes
    // (ie. user taps Allow on the permission prompt in iOS)
  });

  OneSignal.shared.setSubscriptionObserver((OSSubscriptionStateChanges changes) {
    // Will be called whenever the subscription changes
    // (ie. user gets registered with OneSignal and gets a user ID)
  });

  OneSignal.shared.setEmailSubscriptionObserver((OSEmailSubscriptionStateChanges emailChanges) {
    // Will be called whenever then user's email subscription changes
    // (ie. OneSignal.setEmail(email) is called and the user gets registered
  });*/

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
  
    UserNotificationsList(),
  ];

  @override
  Widget build(BuildContext context) {
  //  FirebaseCrashlytics.instance.crash();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider(create: (BuildContext context) =>OrdersProvider(),
          child: MyHomePage(title: 'vendor',)),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _incrementCounter();


  }

  void _incrementCounter() async{
    //await Firebase.initializeApp();
    //FirebaseCrashlytics.instance.crash();

  }



  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
   return MaterialApp(
        // localizationsDelegates: [
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        //   GlobalCupertinoLocalizations.delegate,
        // ],
        // supportedLocales: [
        //   const Locale('ar', 'AE'), // Arabic, no country code
        // ],
        // locale: Locale("ar", "AE"),
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Almarai',
          primaryColor: Color.fromRGBO(0, 178, 147, 1),
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: VendorLogin()
        // FutureBuilder<bool>(
        //   // future: true,
        //   //isAuth(),
        //   builder: (buildContext, isLogin) {
        //     if (isLogin.hasData) {
        //       print(isLogin);
        //       if (isLogin.data) {
        //         return MainScreen();
        //       } else {
        //         return MainScreen();
        //       }
        //     } else {
        //       print(isLogin);

        //                      return MainScreen();

        //     }
        //   },
        // )

        //  isAuth()
        //     ? Login()
        //     : MyHomePage(
        //         title: "dart home page",
        //       ),
        );
  }
}
