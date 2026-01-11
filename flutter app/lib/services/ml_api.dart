import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class MlApi {
  static const String _apiKey =
      "https://dark-route-backend.onrender.com/";

  static const String _endpoint =
      "https://generativelanguage.googleapis.com/v1/models/gemini-pro-vision:generateContent";

  static Future<String> analyzeCattle(File image) async {
    try {
      final bytes = await image.readAsBytes();
      final base64Image = base64Encode(bytes);

      final body = {
        "contents": [
          {
            "parts": [
              {
                "text":
                    "Analyze this image. If it is cattle, return size, health, approximate age, and color pattern. If it is not cattle, reply ONLY: NOT A CATTLE."
              },
              {
                "inlineData": {
                  "mimeType": "image/jpeg",
                  "data": base64Image
                }
              }
            ]
          }
        ]
      };

      final response = await http.post(
        Uri.parse("$_endpoint?key=$_apiKey"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode != 200) {
        return "API ERROR ${response.statusCode}: ${response.body}";
      }

      final data = jsonDecode(response.body);
      return data["candidates"][0]["content"]["parts"][0]["text"];
    } catch (e) {
      return "API EXCEPTION: $e";
    }
  }
}
