// import 'package:url_launcher/url_launcher.dart';
//
// class MapUtils {
//   MapUtils._();
//
//   static Future<void> openMap(double latitude, double longitude) async {
//     final String googleMapUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
//     final Uri googleMapUri = Uri.parse(googleMapUrl);
//
//     if (await canLaunchUrl(googleMapUri)) {
//       await launchUrl(
//         googleMapUri,
//         mode: LaunchMode.externalApplication, // Ensure it opens in an external application
//       );
//     } else {
//       throw 'Could not open the map';
//     }
//   }
// }
