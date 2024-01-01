import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

Future<double> getPdfSize(String pdfLink) async {
  try {
    http.Response response = await http.get(Uri.parse(pdfLink));

    if (response.statusCode == 200) {
      Uint8List pdfBytes = Uint8List.fromList(response.bodyBytes);
      double sizeInMB = pdfBytes.lengthInBytes / (1024 * 1024);

      return sizeInMB;
    } else {
      throw Exception('Failed to download PDF: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
    return -1; // Return -1 to indicate an error
  }
}
