import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:salesoft_hrm/pages/ChamCong/reason_dialog.dart';
import 'package:salesoft_hrm/pages/login/login_controller.dart';
import 'package:salesoft_hrm/widgets/dialog_thanhcong.dart';
import 'package:salesoft_hrm/widgets/dialog_thatbai.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/provider/calamviec_provider.dart';
import 'package:salesoft_hrm/API/provider/diadiem_provider.dart';
import 'package:salesoft_hrm/API/repository/calamviec_repository.dart';
import 'package:salesoft_hrm/API/repository/diadiem_repository.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/url_helper.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/model/calamviec_model.dart';

class Location {
  final String ma;
  final String name;
  final MyLatLng coordinates;
  final int distance;
  bool isSelected;

  Location(this.ma, this.name, this.coordinates, this.distance,
      {this.isSelected = false});
}

class MyLatLng {
  final double latitude;
  final double longitude;

  MyLatLng(this.latitude, this.longitude);
}

class checkinController extends GetxController {
  String _btnChamCongText = 'Chấm công';

  String get btnChamCongText => _btnChamCongText;
  var currentMinutes = 0.obs;
  bool _reasonDialog2Shown = false;
  bool get reasonDialog2Shown => _reasonDialog2Shown;
  RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );
  late Timer _timer;
  String selectedShift = '';
  String btnChamCong = '';
  String selectedShiftMa = '';
  bool isButtonVisible = true;
  Completer<GoogleMapController> controllerCompleter = Completer();
  GoogleMapController? googleMapController1;
  GoogleMapController? googleMapController2;
  Location? selectedOffice;

  late String selectedLocation;
  MyLatLng? currentLocation;
  TextEditingController distanceController = TextEditingController();
  //list tọa độ
  List<Location> offices = [];
  List<Marker> markers = [];

  List<CaLamViec> ca = [
    //   CaLamViec(
    //   ten: 'Ca sáng',
    //   gioVao: '13:00',
    //   gioRa: '14:00',
    // ),
  ];
  late int checkInH, checkInM, checkOutH, checkOutM;
  String checkInTime = '', checkOutTime = '';
  bool isOnTime = false;

  @override
  Future<void> onInit() async {
    super.onInit();

    isCheckedIn = box.read('isCheckedIn') ?? false;
    isCheckedOut = box.read('isCheckedOut') ?? false;
    if (currentLocation == null) {
      getCurrentLocation();
    }

    checkIn();
    // updateCheckInStatus(_checkCCIn);
  }
  //   void updateCheckInStatus(bool value) {
  //   _checkCCIn = value;
  //   update();
  //   print('giá trị _checkcc:$_checkCCIn');
  // }

  Future<void> getCaLamViecList() async {
    try {
      final calamProvider = CaLamProviderAPI(AuthService());
      final calamRepository = CaLamRepository(provider: calamProvider);
      final caLamList = await calamRepository.getCaLam();
      if (caLamList != null && caLamList.caLamList.isNotEmpty) {
        ca.clear();
        ca = caLamList.caLamList;
        update();
      } else {
        print('Không có dữ liệu ca làm việc');
      }
    } catch (e) {
      print('Lỗi khi lấy dữ liệu CaLamViec: $e');
    }
  }

  Future<void> fetchCurrentMinutes() async {
    final response = await http.get(
        Uri.parse('https://apihrm.pmcweb.vn/api/RegSystem/GetDateTimeNow'));

    if (response.statusCode == 200) {
      String responseTime = json.decode(response.body);

      DateTime parsedTime = DateTime.parse(responseTime).toLocal();

      String formattedTime = DateFormat('HH:mm').format(parsedTime);

      currentMinutes.value = parsedTime.hour * 60 + parsedTime.minute;

      print('Current Time (HH:mm) in +07:00: $formattedTime +07:00');
      print('Current minutes from start of day: ${currentMinutes.value}');
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  }

  Future<int?> fetchValue() async {
    const String url =
        'https://apihrm.pmcweb.vn/api/RegSystem/GetValueByCode?Code=CC.ThoiGianDiMuon';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        String? thoiGianDiMuon = data['value'];
        return int.tryParse(thoiGianDiMuon ?? '');
      } else {
        print('Failed to load value: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
    return null;
  }

  Future<int?> fetchValue2() async {
    const String url =
        'https://apihrm.pmcweb.vn/api/RegSystem/GetValueByCode?Code=CC.ThoiGianCCVao';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        String? thoiGianCCVao = data['value'];
        return int.tryParse(thoiGianCCVao ?? '');
      } else {
        print('Failed to load value: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
    return null;
  }

  Future<int?> fetchValue3() async {
    const String url =
        'https://apihrm.pmcweb.vn/api/RegSystem/GetValueByCode?Code=CC.ThoiGianCCRa';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        String? thoiGianCCRa = data['value'];
        return int.tryParse(thoiGianCCRa ?? '');
      } else {
        print('Failed to load value: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
    return null;
  }

  Future<void> getDiaDiemList() async {
    try {
      final diaDiemProvider = DiaDiemProviderAPI(AuthService());
      final diaDiemRepository = DiaDiemRepository(provider: diaDiemProvider);
      final diaDiemList = await diaDiemRepository.getDiaDiem();

      if (diaDiemList != null && diaDiemList.diaDiemList.isNotEmpty) {
        offices.clear();
        offices.addAll(diaDiemList.diaDiemList
            .where((diaDiem) =>
                diaDiem.ten != null &&
                diaDiem.viDo != null &&
                diaDiem.kinhDo != null)
            .map((diaDiem) {
          double latitude = double.parse(diaDiem.viDo!);
          double longitude = double.parse(diaDiem.kinhDo!);
          int distance = diaDiem.khoangCach!;
          return Location(diaDiem.ma!, diaDiem.ten!,
              MyLatLng(latitude, longitude), distance);
        }).toList());

        updateMarkers();
        print('Danh sách địa điểm: $offices');
      } else {
        print('Không có dữ liệu địa điểm');
      }
    } catch (e) {
      print('Lỗi khi lấy dữ liệu DiaDiem: $e');
    }
  }

  final box = GetStorage();

  bool _isCheckedIn = false;

  bool get isCheckedIn => _isCheckedIn;

  set isCheckedIn(bool value) {
    _isCheckedIn = value;
    box.write('isCheckedIn', value);
    update();
  }

  bool _isCheckedOut = false;

  bool get isCheckedOut => _isCheckedOut;

  set isCheckedOut(bool value) {
    _isCheckedOut = value;
    box.write('isCheckedOut', value);
    update();
  }

  String _checkInTime = '';

  void getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      currentLocation = MyLatLng(position.latitude, position.longitude);
      await updateBtnChamCong();
      await getCaLamViecList();
      await getDiaDiemList();
      await updateSelectedShift();
      fetchCurrentMinutes();
      fetchValue();
      fetchValue2();
      update();

      if (offices.isNotEmpty) {
        selectClosestOffice();
      } else {
        print('Danh sách văn phòng rỗng');
      }
    } catch (e) {
      print('Không thể lấy vị trí hiện tại: $e');
    }
  }

  void toggleSelectedOffice(String officeName) async {
    selectedOffice = offices.firstWhere((office) => office.name == officeName);
    update();

    if (googleMapController1 != null && selectedOffice != null) {
      LatLng targetPosition = LatLng(selectedOffice!.coordinates.latitude,
          selectedOffice!.coordinates.longitude);
      googleMapController1!.animateCamera(
        CameraUpdate.newLatLngZoom(
          targetPosition,
          16.5,
        ),
      );
    }
  }

  void selectClosestOffice() {
    if (offices.isNotEmpty) {
      double minDistance = double.infinity;
      Location? closestOffice;

      for (Location office in offices) {
        double distance = calculateDistance(
          currentLocation!.latitude,
          currentLocation!.longitude,
          office.coordinates.latitude,
          office.coordinates.longitude,
        );
        if (distance < minDistance) {
          minDistance = distance;
          closestOffice = office;
        }
      }

      if (closestOffice != null) {
        toggleSelectedOffice(closestOffice.name);
      } else {
        print('Không tìm thấy văn phòng gần nhất');
      }
    } else {
      print('Không có vị trí hiện tại hoặc danh sách văn phòng rỗng');
    }
  }

  Future<void> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      Get.dialog(
        thongBaoDialog2(
          text: 'Bạn cần cấp quyền truy cập vị trí để sử dụng ứng dụng này',
        ),
      );
    } else {
      getCurrentLocation();
    }
  }

  void selectOffice(Location office) {
    selectedOffice = office;
    for (Location o in offices) {
      o.isSelected = (o == office);
    }
    update();
  }

  void getCurrentLocation2(int mapIndex) {
    if (mapIndex == 1 && googleMapController1 != null) {
      googleMapController1!.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(
            currentLocation!.latitude!,
            currentLocation!.longitude!,
          ),
          16.5,
        ),
      );
    } else if (mapIndex == 2 && googleMapController2 != null) {
      googleMapController2!.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(
            currentLocation!.latitude,
            currentLocation!.longitude,
          ),
          16.5,
        ),
      );
    }
  }

  double calculateDistance(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) {
    const int earthRadius = 6371000;
    double lat1Radians = degreesToRadians(startLatitude);
    double lon1Radians = degreesToRadians(startLongitude);
    double lat2Radians = degreesToRadians(endLatitude);
    double lon2Radians = degreesToRadians(endLongitude);

    double latDifference = lat2Radians - lat1Radians;
    double lonDifference = lon2Radians - lon1Radians;

    double a = pow(sin(latDifference / 2), 2) +
        cos(lat1Radians) * cos(lat2Radians) * pow(sin(lonDifference / 2), 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double distance = earthRadius * c;

    return distance;
  }

  double degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  bool isSelectedOffice(String officeName) {
    for (Location office in offices) {
      if (office.name == officeName) {
        return office.isSelected;
      }
    }
    return false;
  }

  void checkIn() async {
    fetchCurrentMinutes();
    final tokenController = Get.find<TokenController>();
    String? fcmToken = tokenController.getToken();
    if (currentLocation == null) {
      print('Đang đợi lấy vị trí hiện tại...');
      return;
    }

    double distanceThreshold = double.tryParse(distanceController.text) ?? 0;
    if (distanceThreshold <= 0) {
      Get.dialog(
        thongBaoDialog2(
          text: 'Khoảng cách chấm công không hợp lệ',
        ),
      );
      return;
    }

    if (selectedOffice == null) {
      Get.dialog(
        thongBaoDialog2(
          text: 'Bạn chưa được gán địa điểm chấm công',
        ),
      );
      return;
    }

    double distanceToOffice = calculateDistance(
      currentLocation!.latitude,
      currentLocation!.longitude,
      selectedOffice!.coordinates.latitude,
      selectedOffice!.coordinates.longitude,
    );

    CaLamViec? selectedShiftModel = findSelectedShiftModel();
    dio.Response? response = await checkVao(selectedShiftModel!.ma!);
    dio.Response? response2 = await checkRa(selectedShiftModel.ma!);
    int? thoiGianDiMuon = await fetchValue();
    int? thoiGianCCVao = await fetchValue2();
    int? thoiGianCCRa = await fetchValue3();
    if (selectedShiftModel != null) {
      int timeInMinutes = _convertToMinutes(selectedShiftModel.gioVao);
      int timeOutMinutes = _convertToMinutes(selectedShiftModel.gioRa);
      if (timeInMinutes >= timeOutMinutes) {
        if (timeOutMinutes <= currentMinutes.value &&
            currentMinutes.value <= 1439) {
          timeOutMinutes = timeOutMinutes;
          currentMinutes = currentMinutes;
          timeInMinutes = timeInMinutes;
        } else {
          print('current:$currentMinutes');

          timeOutMinutes += 1440;
          currentMinutes += 1440;
        }
      }
      print('timeIn:$timeInMinutes');
      print('timeOut:$timeOutMinutes');
      print('current:$currentMinutes');
      if (selectedOffice!.distance != 0 &&
          distanceToOffice <= selectedOffice!.distance) {
        if (timeInMinutes - thoiGianCCVao! <= currentMinutes.value &&
            currentMinutes.value <= timeInMinutes + thoiGianDiMuon!) {
          if (response != null && response.statusCode == 204) {
            await postChamCong(
                fcmToken!, selectedShiftModel.ma, selectedOffice!.ma, true, '');
          } else if (response != null && response.statusCode == 200) {
            Get.dialog(
              thongBaoDialog2(
                text: 'Bạn đã chấm công vào',
              ),
            );
          }
        } else if (timeInMinutes + thoiGianDiMuon! < currentMinutes.value &&
            currentMinutes.value <= timeInMinutes + thoiGianCCVao) {
          if (response != null && response.statusCode == 204) {
            Get.dialog(ReasonDialog()).then((reason) async {
              if (reason != null) {
                await postChamCong(fcmToken!, selectedShiftModel.ma,
                    selectedOffice!.ma, true, reason);

                print('ab');
              }
            });
          } else if (response != null && response.statusCode == 200) {
            Get.dialog(
              thongBaoDialog2(
                text: 'Bạn đã chấm công vào',
              ),
            );
          }
        } else if (timeOutMinutes - thoiGianDiMuon <= currentMinutes.value &&
            currentMinutes.value < timeOutMinutes) {
          if (response2 != null && response2.statusCode == 204) {
            // Get.dialog(ReasonDialog2()).then((reason) async {
            //   _reasonDialog2Shown = false;
            //   if (reason != null) {
            //     await postChamCong(fcmToken!, selectedShiftModel.ma,
            //         selectedOffice!.ma, false, reason);

            //     print('ab');
            //   }
            // });
            await postChamCong(fcmToken!, selectedShiftModel.ma,
                selectedOffice!.ma, false, '');
          } else if (response2 != null && response2.statusCode == 200) {
            Get.dialog(
              thongBaoDialog2(
                text: 'Bạn đã chấm công ra',
              ),
            );
          }
        } else if (timeOutMinutes <= currentMinutes.value &&
            currentMinutes.value <= timeOutMinutes + thoiGianCCRa!) {
          if (response2 != null && response2.statusCode == 204) {
            await postChamCong(fcmToken!, selectedShiftModel.ma,
                selectedOffice!.ma, false, '');
          } else if (response2 != null && response2.statusCode == 200) {
            Get.dialog(
              thongBaoDialog2(
                text: 'Bạn đã chấm công ra',
              ),
            );
          }
        } else {
          if (currentMinutes < timeInMinutes) {
            Get.dialog(
              thongBaoDialog2(
                text: 'Chưa tới giờ chấm công vào',
              ),
            );
          } else if (currentMinutes < timeOutMinutes &&
              currentMinutes > timeInMinutes) {
            Get.dialog(
              thongBaoDialog2(
                text: 'Quá giờ chấm công vào/Chưa tới giờ chấm công ra',
              ),
            );
          } else if (currentMinutes > timeOutMinutes) {
            Get.dialog(
              thongBaoDialog2(
                text: 'Quá giờ chấm công ra',
              ),
            );
          }
        }
      } else if (selectedOffice!.distance == 0 &&
          distanceToOffice <= distanceThreshold) {
        if (timeInMinutes - thoiGianCCVao! <= currentMinutes.value &&
            currentMinutes.value <= timeInMinutes + thoiGianDiMuon!) {
          if (response != null && response.statusCode == 204) {
            await postChamCong(
                fcmToken!, selectedShiftModel.ma, selectedOffice!.ma, true, '');
          } else if (response != null && response.statusCode == 200) {
            Get.dialog(
              thongBaoDialog2(
                text: 'Bạn đã chấm công vào',
              ),
            );
          }
        } else if (timeInMinutes + thoiGianDiMuon! < currentMinutes.value &&
            currentMinutes <= timeInMinutes + thoiGianCCVao) {
          if (response != null && response.statusCode == 204) {
            Get.dialog(ReasonDialog()).then((reason) async {
              if (reason != null) {
                await postChamCong(fcmToken!, selectedShiftModel.ma,
                    selectedOffice!.ma, true, reason);

                print('ab');
              }
            });
          } else if (response != null && response.statusCode == 200) {
            Get.dialog(
              thongBaoDialog2(
                text: 'Bạn đã chấm công vào',
              ),
            );
          }
        } else if (timeOutMinutes - thoiGianDiMuon <= currentMinutes.value &&
            currentMinutes.value < timeOutMinutes) {
          if (response2 != null && response2.statusCode == 204) {
            // Get.dialog(ReasonDialog2()).then((reason) async {
            //   if (reason != null) {
            //     await postChamCong(fcmToken!, selectedShiftModel.ma,
            //         selectedOffice!.ma, false, reason);

            //     print('ab');
            //   }
            // });
            await postChamCong(fcmToken!, selectedShiftModel.ma,
                selectedOffice!.ma, false, '');
          } else if (response2 != null && response2.statusCode == 200) {
            Get.dialog(
              thongBaoDialog2(
                text: 'Bạn đã chấm công ra',
              ),
            );
          }
        } else if (timeOutMinutes <= currentMinutes.value &&
            currentMinutes.value <= timeOutMinutes + thoiGianCCRa!) {
          if (response2 != null && response2.statusCode == 204) {
            await postChamCong(fcmToken!, selectedShiftModel.ma,
                selectedOffice!.ma, false, '');
          } else if (response2 != null && response2.statusCode == 200) {
            Get.dialog(
              thongBaoDialog2(
                text: 'Bạn đã chấm công ra',
              ),
            );
          }
        } else {
          if (currentMinutes < timeInMinutes) {
            Get.dialog(
              thongBaoDialog2(
                text: 'Chưa tới giờ chấm công vào',
              ),
            );
          } else if (currentMinutes < timeOutMinutes &&
              currentMinutes > timeInMinutes) {
            Get.dialog(
              thongBaoDialog2(
                text: 'Quá giờ chấm công vào/Chưa tới giờ chấm công ra',
              ),
            );
          } else if (currentMinutes > timeOutMinutes) {
            Get.dialog(
              thongBaoDialog2(
                text: 'Quá giờ chấm công ra',
              ),
            );
          }
        }
      } else {
        Get.dialog(
          thongBaoDialog2(
            text: 'Bạn đang ở quá xa văn phòng',
          ),
        );
      }
    } else {
      Get.dialog(
        thongBaoDialog2(
          text: 'Không tìm thấy thông tin ca làm việc đã chọn',
        ),
      );
    }
  }

  CaLamViec? findSelectedShiftModel() {
    if (ca.isNotEmpty) {
      return ca.firstWhereOrNull(
        (shift) =>
            '${shift.ten} (${shift.gioVao} - ${shift.gioRa})' == selectedShift,
      );
    }
    return null;
  }

  int _convertToMinutes(String? time) {
    if (time == null) return 0;
    List<String> parts = time.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    return hour * 60 + minute;
  }

  Future<void> updateSelectedShift() async {
    selectedShift = '';
    int? value = await fetchValue();
    int? value2 = await fetchValue2();

    if (ca.isNotEmpty) {
      if (ca.length == 1) {
        final shift = ca.first;
        selectedShift = '${shift.ten} (${shift.gioVao} - ${shift.gioRa})';
        isCheckedOut = false;
      } else {
        for (CaLamViec shift in ca) {
          int timeInMinutes = _convertToMinutes(shift.gioVao);
          int timeOutMinutes = _convertToMinutes(shift.gioRa);

          if (currentMinutes.value >= timeInMinutes - value2! &&
              currentMinutes <= timeOutMinutes + value!) {
            selectedShift = '${shift.ten} (${shift.gioVao} - ${shift.gioRa})';
            isCheckedOut = false;
            break;
          } else {
            final firstShift = ca.first;
            selectedShift =
                '${firstShift.ten} (${firstShift.gioVao} - ${firstShift.gioRa})';
            isCheckedOut = false;
          }
        }
      }
    } else {
      selectedShift = 'Không có ca làm việc';
      isCheckedOut = false;
    }
    update();
  }

  Future<void> updateBtnChamCong() async {
    btnChamCong = '';
    int? thoiGianDiMuon = await fetchValue();
    int? thoiGianCCVao = await fetchValue2();
    int? thoiGianCCRa = await fetchValue3();
    if (ca.isNotEmpty) {
      for (CaLamViec shift in ca) {
        int timeInMinutes = _convertToMinutes(shift.gioVao);
        int timeOutMinutes = _convertToMinutes(shift.gioRa);

        if (currentMinutes.value >= timeInMinutes - thoiGianCCVao! &&
            currentMinutes.value <= timeInMinutes + thoiGianCCVao) {
          _btnChamCongText = 'Chấm công vào';
          isButtonVisible = true;
          update();
          return;
        } else if (currentMinutes.value >= timeOutMinutes - thoiGianDiMuon! &&
            currentMinutes.value <= timeOutMinutes + thoiGianCCRa!) {
          _btnChamCongText = 'Chấm công ra';
          isButtonVisible = true;
          update();
          return;
        }
      }
    }
  }

  void updateMarkers() {
    markers.clear();

    for (int i = 0; i < offices.length; i++) {
      Location location = offices[i];
      markers.add(
        Marker(
          markerId: MarkerId('Office ${i + 1}'),
          position: LatLng(
              location.coordinates.latitude, location.coordinates.longitude),
          infoWindow: InfoWindow(
            title:
                '${location.name} (${location.coordinates.latitude}, ${location.coordinates.longitude})',
          ),
        ),
      );
    }

    update();
  }

  Future<void> postChamCong(String token, String? ca, String diaDiem,
      bool checkIn, String lyDo) async {
    final prefs = await SharedPreferences.getInstance();
    final ma = prefs.getString('ma');

    if (ma == null) {
      print('Không tìm thấy mã trong SharedPreferences');
      return;
    }

    final urlEndPoint =
        "${URLHelper.NS_ChamCong}?Ma=$ma&Token=$token&CaLamViec=$ca&DiaDiem=$diaDiem&CheckIn=$checkIn&LyDo=$lyDo";

    try {
      final response = await HttpUtil().post(
        urlEndPoint,
        params: {
          'Ma': ma,
          'Token': token,
          'CaLamViec': ca,
          'DiaDiem': diaDiem,
          'CheckIn': checkIn,
          'LyDo': lyDo
        },
      );

      print(response['message']);

      if (response['status'] == "Success") {
        Get.dialog(
          thongBaoDialog(
            text: response['message'] ?? 'Đã chấm công thành công',
          ),
        );
      } else if (response['status'] == "Error") {
        Get.dialog(
          thongBaoDialog2(
            text: response['message'] ?? 'Chấm công không thành công',
          ),
        );
      }
    } catch (e) {
      print('Có lỗi xảy ra: $e');
      if (e is DioException) {
        Get.dialog(
          thongBaoDialog2(
            text: 'Không thể dùng một thiết bị chấm công cho nhiều nhân sự',
          ),
        );
      } else {
        Get.dialog(
          thongBaoDialog2(
            text: 'Lỗi kết nối đến server',
          ),
        );
      }
    }
  }

  Future<dio.Response?> checkVao(String caLamViec) async {
    final prefs = await SharedPreferences.getInstance();
    final ma = prefs.getString('ma');

    if (ma == null) {
      print('Không tìm thấy mã trong SharedPreferences');
      return null;
    }

    final urlEndPoint = '${URLHelper.NS_CheckVao}?Ma=$ma&CaLamViec=$caLamViec';
    try {
      final response = await HttpUtil().post2(
          'https://apihrm.pmcweb.vn/api/$urlEndPoint',
          params: {'Ma': ma, 'CaLamViec': caLamViec});
      return response;
    } catch (e) {
      print('Lỗi khi kiểm tra chấm công: $e');
      return null;
    }
  }

  Future<dio.Response?> checkRa(String caLamViec) async {
    final prefs = await SharedPreferences.getInstance();
    final ma = prefs.getString('ma');

    if (ma == null) {
      print('Không tìm thấy mã trong SharedPrefences');
      return null;
    }
    final urlEndPoint = '${URLHelper.NS_CheckRa}?Ma=$ma&CaLamViec=$caLamViec';
    try {
      final response = await HttpUtil().post2(
          'https://apihrm.pmcweb.vn/api/$urlEndPoint',
          params: {'Ma': ma, 'CaLamViec': caLamViec});
      return response;
    } catch (e) {
      print('Lỗi khi kiểm tra chấm công2:$e');
      return null;
    }
  }
}
