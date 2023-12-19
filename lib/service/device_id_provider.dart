// // ignore_for_file: avoid_print

// import 'package:device_info_plus/device_info_plus.dart';
// import 'dart:io';

// class DeviceIdProvider {
//   Future<String?> getId() async {
//     var deviceInfo = DeviceInfoPlugin();
//     try {
//       if (Platform.isIOS) {
//         var iosDeviceInfo = await deviceInfo.iosInfo;
//         return iosDeviceInfo.identifierForVendor.toString(); // unique ID on iOS
//       } else if (Platform.isAndroid) {
//         var androidDeviceInfo = await deviceInfo.androidInfo;
//         return androidDeviceInfo.androidId.toString(); // convert to string
//       }
//     } catch (e) {
//       // Handle any exceptions that might occur while fetching device info
//       print('Error fetching device info: $e');
//     }

//     // For web, generate a unique ID using the uuid package
//     return 'unique-id-123456';
//   }
// }
