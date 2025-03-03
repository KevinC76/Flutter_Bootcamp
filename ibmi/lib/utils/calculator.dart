import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

double calculatorBMI(int height, int weight) {
  return 703 * (weight / pow(height, 2));
}

Future<double> calculateBMIAsync(Dio _dio) async {
//   // Create a custom HttpClient that ignores SSL errors
//   var httpClient = HttpClient()
//     ..badCertificateCallback =
//         (X509Certificate cert, String host, int port) => true;

// // Use the custom HttpClient to create a Dio instance
//   (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
//     return httpClient;
//   };

  var _result = await _dio.get('https://jsonkeeper.com/b/AKFA');
  var _data = _result.data;
  var _bmi = calculatorBMI(
    _data['Sergio Ramos'][0],
    _data['Sergio Ramos'][1],
  );
  return _bmi;
}
