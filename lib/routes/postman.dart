// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'users.dart';

// Future<Map<String, dynamic>> fetchData() async {
//   Map<String, dynamic> _data = {};
//   var request = http.Request(
//       'GET',
//       Uri.parse(
//           'https://guac.nullchapter.tech/api/session/data/postgresql/connections?token=D13CE17BC67D54392C8DF914C8DBC3D5485325B967908A352DFED90BE0BCE5AE'));
//   http.StreamedResponse response = await request.send();
// //   if (response.statusCode == 200) {
// //   return await response.stream.bytesToString();
// // }
// // else {
// //   print(response.reasonPhrase);
// // }
//   if (response.statusCode == 200) {
//     final data = await response.stream.bytesToString();
//     final decodedData = jsonDecode(data) as Map<String, dynamic>;
//     setState(() {
//         _data = decodedData;
//       });
//     return decodedData;
    
//   } else {
//     print(response.reasonPhrase);
//     throw Exception('Failed to fetch data');
//   }
// }

