import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio_pkg;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:salesoft_hrm/API/url_helper.dart';
import 'package:salesoft_hrm/common/app_global.dart';
import 'package:salesoft_hrm/common/router.dart';
import 'package:salesoft_hrm/model/base_model.dart';
import 'package:salesoft_hrm/model/error_model.dart';
import 'package:http/http.dart'
    as http; // Import http package for http.Response

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();
  factory HttpUtil() => _instance;

  late Dio dio;

  CancelToken cancelToken = CancelToken();

  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: URLHelper.urlRequest,
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 5000),
      headers: {},
      contentType: 'application/json; charset=utf-8',
      responseType: ResponseType.json,
    );

    dio = Dio(options);
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));
  }

  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }

  Map<String, dynamic>? getAuthorizationHeader() {
    // var headers;
    // String accessToken = Global.profile?.accessToken;
    // if (accessToken != null) {
    //   headers = {
    //     'Authorization': 'Bearer $accessToken',
    //   };
    // }
    return null;
  }

  ///
  /// Kiểm tra quyền đăng nhập người dùng
  ///
  void checkShouldLogout(dynamic data) {
    if (data is List) {
      final listError = BaseModel.listFromJson<ErrorModel>(
          data, (dataMap) => ErrorModel.fromMap(dataMap));
      if (listError.isNotEmpty && listError.first.content?.isNotEmpty == true) {
        showToast(listError.first.content ?? '');
        Get.until((route) => Get.currentRoute == ERouter.mainPage.name);
        // final AccountController accountController = Get.find();
        // accountController.logoutAction();
      }
    }
  }

  Future<dynamic> get(
    String path, {
    dynamic params,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();

    // Map<String, dynamic>? _authorization = getAuthorizationHeader();
    // if (_authorization != null) {
    //   requestOptions = requestOptions.merge(headers: _authorization);
    // }

    var response = await dio.get(
      path,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    // checkShouldLogout(response.data);
    return response.data;
  }

  /// restful post
  Future<dynamic> post(
    String path, {
    dynamic params,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    // Map<String, dynamic> _authorization = getAuthorizationHeader();
    // if (_authorization != null) {
    //   requestOptions = requestOptions.merge(headers: _authorization);
    // }
    var response = await dio.post(
      path,
      data: params,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    checkShouldLogout(response.data);
    return response.data;
  }

  Future<dio_pkg.Response?> post2(String url,
      {Map<String, dynamic>? params}) async {
    try {
      final response = await dio.post(url, data: params);
      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');
      return response;
    } catch (e) {
      print('Lỗi khi gọi API: $e');
      return null;
    }
  }

  /// restful put 操作
  Future<dynamic> put(
    String path, {
    dynamic params,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    var response = await dio.put(
      path,
      data: params,
      options: requestOptions,
      cancelToken: cancelToken,
    );

    print('Response status: ${response.statusCode}');
    print('Response data: ${response.data}');

    checkShouldLogout(response.data);
    return response;
  }

  Future<http.Response> put2(
    String path, {
    dynamic params,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();

    var response = await dio.put(
      path,
      data: params,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    checkShouldLogout(response.data);

    // Ensure that statusCode is non-null
    final statusCode = response.statusCode ?? 0;

    // Convert Map<String, List<String>> to Map<String, String>
    final headers = response.headers.map
        .map((key, value) => MapEntry(key, value.join(',')));

    return http.Response(
      response.data.toString(),
      statusCode,
      headers: headers,
    );
  }

  /// restful patch
  Future<dynamic> patch(
    String path, {
    dynamic params,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    // Map<String, dynamic> _authorization = getAuthorizationHeader();
    // if (_authorization != null) {
    //   requestOptions = requestOptions.merge(headers: _authorization);
    // }
    var response = await dio.patch(path,
        data: params, options: requestOptions, cancelToken: cancelToken);
    checkShouldLogout(response.data);
    return response.data;
  }

  /// restful delete
  Future<dynamic> delete(
    String path, {
    dynamic params,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    // Map<String, dynamic> _authorization = getAuthorizationHeader();
    // if (_authorization != null) {
    //   requestOptions = requestOptions.merge(headers: _authorization);
    // }
    var response = await dio.delete(path,
        data: params, options: requestOptions, cancelToken: cancelToken);
    checkShouldLogout(response.data);
    return response.data;
  }

  /// restful post form 表单提交操作
  // Future<dynamic> postForm(
  //   String path, {
  //   dynamic params,
  //   Options? options,
  // }) async {
  //   Options requestOptions = options ?? Options();
  //   // Map<String, dynamic> _authorization = getAuthorizationHeader();
  //   // if (_authorization != null) {
  //   //   requestOptions = requestOptions.merge(headers: _authorization);
  //   // }
  //   var response = await dio.post(path,
  //       data: FormData.fromMap(params),
  //       options: requestOptions,
  //       cancelToken: cancelToken);
  //   return response.data;
  // }
}

class ErrorEntity implements Exception {
  int? code;
  String? message;
  ErrorEntity({this.code, this.message});

  @override
  String toString() {
    if (message == null) return "Exception";
    return "Exception: code $code, $message";
  }
}
