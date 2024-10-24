import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/Splash.dart';
import 'package:salesoft_hrm/common/router.dart';
import 'package:salesoft_hrm/main_controller.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:io' show Platform;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.isEmpty) {
    final FirebaseOptions firebaseOptions = (Platform.isIOS || Platform.isMacOS)
        ? const FirebaseOptions(
            apiKey: 'AIzaSyCAYT6ri4dd5HPHXfgeoNEajvVpf61ddxg',
            appId: '1:1020659991482:ios:bc27a707c9a387e8789383',
            messagingSenderId: '1020659991482',
            projectId: 'hrm-pmc',
            storageBucket: 'hrm-pmc.appspot.com',
            databaseURL: 'https://hrm-pmc.firebaseio.com/',
          )
        : const FirebaseOptions(
            apiKey: 'AIzaSyDVrIA-hJ-5j7PbvbzaeOf4u8LyBsiO2oo',
            appId: '1:1020659991482:android:24b84c9fbad0b5aa789383',
            messagingSenderId: '1020659991482',
            projectId: 'hrm-pmc',
            storageBucket: 'hrm-pmc.appspot.com',
            databaseURL: 'https://hrm-pmc.firebaseio.com/',
          );

    await Firebase.initializeApp(
      name: "hrm-pmc",
      options: firebaseOptions,
    );
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

Future<void> init() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? token = await messaging.getAPNSToken();

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      _showSnackbar(message.notification!.title, message.notification!.body);
    }
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else {
    print('User declined or has not accepted permission');
  }
}

void _showSnackbar(String? title, String? body) {
  Get.snackbar(
    title ?? 'Thông báo',
    body ?? '',
    snackPosition: SnackPosition.TOP,
    duration: Duration(seconds: 2),
    colorText: Colors.black,
    backgroundColor: Colors.white,
  );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  
  DateTime? _lastActiveTime;

  @ override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
   @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (_lastActiveTime != null &&
          DateTime.now().difference(_lastActiveTime!).inMinutes >= 30) {
        _reloadApp(); 
      }
    } else if (state == AppLifecycleState.paused) {
      _lastActiveTime = DateTime.now();
    }
  }
  void _showSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 5),
      backgroundColor: Colors.black.withOpacity(0.7),
      colorText: Colors.white,
    );
  }

  

  void _reloadApp() {
  Get.offAll(() =>  SplashScreen());
}


 

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(360, 690),
    );

    Get.put(MainController());
    Get.put(AuthService());

    return GestureDetector(
      child: GetCupertinoApp(
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.0)),
            child: child!,
          );
        },
        debugShowCheckedModeBanner: false,
        getPages: RouterPage.routers,
        home: SplashScreen(),
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('vi', 'VN'),
        ],
        locale: const Locale('en', 'US'),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale!.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
      ),
    );
  }
}
