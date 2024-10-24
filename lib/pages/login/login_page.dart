import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/pages/login/login_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/url_helper.dart';
import 'package:salesoft_hrm/bottom_menu.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/main_controller.dart';
import 'package:salesoft_hrm/pages/Home/home_controller.dart';
import 'package:salesoft_hrm/pages/login/login_controller.dart';
import 'package:salesoft_hrm/resources/app_resource.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool checkToken = false;
  bool rememberMe = false;
  bool isLoading = false;
  bool _obscureText = true;
  final controller = Get.put(LoginController());
  late TextEditingController userPasswordController;
  late TextEditingController userUserNameController;

  @override
  void initState() {
    super.initState();
    checkVersions(context);
    userPasswordController = TextEditingController();
    userUserNameController = TextEditingController();
    _loadRememberedLogin();
  }

  @override
  void dispose() {
    userPasswordController.dispose();
    userUserNameController.dispose();
    super.dispose();
  }

  void _loadRememberedLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    rememberMe = pref.getBool('rememberMe') ?? false;
    if (rememberMe) {
      String? username = pref.getString('username');
      String? password = pref.getString('password');
      if (username != null && password != null) {
        setState(() {
          userUserNameController.text = username;
          userPasswordController.text = password;
          controller.userName.value = username;
          controller.password.value = password;
        });
      }
    }
  }

  Future<void> _showFormDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return QuenMKDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(AuthService());
    Get.put(HomeController());
    final mainController = Get.put(MainController());

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                    height: AppConstant.getScreenSizeHeight(context) * 0.1),
                Image.asset(
                  AppResource.iclogoLogin,
                  height: AppConstant.getScreenSizeHeight(context) * 0.08,
                ),
                SizedBox(
                    height: AppConstant.getScreenSizeHeight(context) * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(
                        fontFamily: 'Arimo',
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image.asset(
                      AppResource.icWelcome,
                      height: AppConstant.getScreenSizeHeight(context) * 0.04,
                    ),
                  ],
                ),
                SizedBox(
                    height: AppConstant.getScreenSizeHeight(context) * 0.02),
                Center(
                  child: Text(
                    'Vui lòng nhập thông tin để đăng nhập',
                    style: TextStyle(
                      fontFamily: 'Arimo',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(
                    height: AppConstant.getScreenSizeHeight(context) * 0.05),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mã nhân viên',
                        style: TextStyle(
                          fontFamily: 'Arimo',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(
                          height:
                              AppConstant.getScreenSizeHeight(context) * 0.01),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 0.5),
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        child: TextField(
                          controller: userUserNameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey[600]),
                          ),
                          onChanged: (value) {
                            controller.userName.value = value;
                            if (rememberMe) {
                              SharedPreferences.getInstance().then((pref) {
                                pref.setString('username', value);
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(
                          height:
                              AppConstant.getScreenSizeHeight(context) * 0.02),
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text(
                              'Mật khẩu',
                              style: TextStyle(
                                fontFamily: 'Arimo',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Expanded(
                            flex: 5,
                            child: GestureDetector(
                              onTap: () {
                                _showFormDialog();
                              },
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Quên mật khẩu',
                                  style: TextStyle(
                                    fontFamily: 'Work Sans',
                                    fontSize: 10.sp,
                                    color: AppColors.blueVNPT,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height:
                              AppConstant.getScreenSizeHeight(context) * 0.01),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 0.5),
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 9,
                              child: TextField(
                                controller: userPasswordController,
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey[600]),
                                ),
                                onChanged: (value) {
                                  controller.password.value = value;
                                  if (rememberMe) {
                                    SharedPreferences.getInstance()
                                        .then((pref) {
                                      pref.setString('password', value);
                                    });
                                  }
                                },
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: FaIcon(
                                  _obscureText
                                      ? FontAwesomeIcons.eyeSlash
                                      : FontAwesomeIcons.eye,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: rememberMe,
                            activeColor: AppColors.blueVNPT,
                            checkColor: Colors.white,
                            onChanged: (bool? value) {
                              setState(() {
                                rememberMe = value ?? false;
                              });
                              SharedPreferences.getInstance().then((pref) {
                                if (rememberMe) {
                                  pref.setString(
                                      'username', controller.userName.value);
                                  pref.setString(
                                      'password', controller.password.value);
                                  pref.setBool('rememberMe', rememberMe);
                                } else {
                                  pref.remove('username');
                                  pref.remove('password');
                                  pref.remove('rememberMe');
                                }
                              });
                            },
                          ),
                          Text(
                            'Nhớ tài khoản',
                            style: TextStyle(
                              fontFamily: 'Arimo',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height:
                              AppConstant.getScreenSizeHeight(context) * 0.01),
                      isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.blueVNPT),
                            ))
                          : SizedBox(
                              width: double.infinity,
                              child: CupertinoButton(
                                onPressed: () async {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  final username = controller.userName.value;
                                  final password = controller.password.value;
                                  if (!controller.isValidateInfo()) {
                                    controller.setErrors();
                                    setState(() {
                                      isLoading = false;
                                    });
                                    return;
                                  }
                                  final authService = Get.find<AuthService>();
                                  final loggedIn = await authService.login(
                                      username, password);
                                  setState(() {
                                    isLoading = false;
                                  });
                                  if (loggedIn) {
                                    controller.clearPassword();
                                    userPasswordController.clear();
                                    Get.find<HomeController>().fetchUserInfo();
                                    mainController.pageIndex.value = 0;

                                    _loginOnClick(context);
                                    String? fcmToken = await FirebaseMessaging
                                        .instance
                                        .getToken();

                                    if (fcmToken != null) {
                                      final tokenController =
                                          Get.put(TokenController());
                                      tokenController.setToken(fcmToken);
                                      await postToken(username, fcmToken);
                                    }

                                    _loginOnClick(context);

                                    if (rememberMe) {
                                      SharedPreferences pref =
                                          await SharedPreferences.getInstance();
                                      await pref.setString(
                                          'username', username);
                                      await pref.setString(
                                          'password', password);
                                      await pref.setBool(
                                          'rememberMe', rememberMe);
                                    } else {
                                      SharedPreferences pref =
                                          await SharedPreferences.getInstance();
                                      await pref.remove('rememberMe');
                                      await pref.remove('username');
                                      await pref.remove('password');
                                    }
                                  } else {
                                    _showPermissionDeniedDialog(context);
                                  }
                                },
                                color: AppColors.blueVNPT,
                                child: Text(
                                  'Đăng nhập',
                                  style: TextStyle(
                                    fontFamily: 'Arimo',
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Center(
                        child: FutureBuilder<PackageInfo>(
                          future: PackageInfo.fromPlatform(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                'Phiên bản ${snapshot.data!.version}',
                                style: TextStyle(
                                    fontFamily: 'Arimo',
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey,
                                    fontSize: 10.sp),
                              );
                            } else {
                              return const Text('Đang tải phiên bản...');
                            }
                          },
                        ),
                      ),
                      SizedBox(
                          height:
                              AppConstant.getScreenSizeHeight(context) * 0.12),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          '© 2024 PMC, All right Reserved',
                          style: TextStyle(
                            fontFamily: 'Work Sans',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> postToken(String ma, String token) async {
    final urlEndPoint = "${URLHelper.NS_Token}?Ma=$ma&Token=$token";
    final response = await HttpUtil().post(
      urlEndPoint,
      params: {'Ma': ma, 'Token': token},
    );
    if (response.statusCode == 200) {
      print('Đã đẩy lên API');
    } else {
      print('Lỗi khi đẩy lên API: ${response.statusCode}');
    }
  }

  void _loginOnClick(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 1500),
        pageBuilder: (_, __, ___) => MainPage(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  void _showPermissionDeniedDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Image.asset(
            AppResource.icWarning,
            height: 80.h,
            width: 80.w,
          ),
          content: Text(
            'Sai thông tin đăng nhập.',
            style: TextStyle(
              fontFamily: 'Arimo',
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: Text(
                'OK',
                style: TextStyle(
                  fontFamily: 'Arimo',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

Future<void> checkVersions(BuildContext context) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;

  print("Current Version: $version");

  final url1 =
      'https://apihrm.pmcweb.vn/api/RegSystem/GetValueByCode?Code=verApp';
  final url2 =
      'https://apihrm.pmcweb.vn/api/RegSystem/GetValueByCode?Code=verApp2';

  try {
    final response1 = await http.get(Uri.parse(url1));
    final response2 = await http.get(Uri.parse(url2));

    if (response1.statusCode == 200 && response2.statusCode == 200) {
      final responseBody1 = jsonDecode(response1.body);
      final responseBody2 = jsonDecode(response2.body);

      String latestVersion1 = responseBody1['value'] ?? '';
      String latestVersion2 = responseBody2['value'] ?? '';

      print("Latest Version from API 1: $latestVersion1");
      print("Latest Version from API 2: $latestVersion2");

      if (version != latestVersion1 && version != latestVersion2) {
        _showVersionAppDialog(context, latestVersion1);
      }
    } else {
      print('Failed to fetch version from API');
    }
  } catch (e) {
    print('Error occurred while fetching version: $e');
  }
}

void _showVersionAppDialog(BuildContext context, String latestVersion) {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Image.asset(
          AppResource.icWarning,
          height: 80.h,
          width: 80.w,
        ),
        content: Text(
          'Đã có phiên bản mới ($latestVersion) vui lòng cài đặt để sử dụng.',
          style: TextStyle(
            fontFamily: 'Arimo',
            fontSize: 12.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
        actions: [
          CupertinoDialogAction(
            child: Text(
              'OK',
              style: TextStyle(
                fontFamily: 'Arimo',
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () async {
              final url = Platform.isAndroid
                  ? 'https://drive.google.com/file/d/13xK1s04HOlHHY33pk_I2i7WpY_xeZuVZ/view?usp=sharing'
                  : 'https://apps.apple.com/app/hrm-pmc/id6504377122';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
        ],
      );
    },
  );
}
