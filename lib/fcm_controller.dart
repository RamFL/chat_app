import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart';

class FcmController {
  static const _SCOPES = [
    //'https://www.googleapis.com/auth/cloud-platform.read-only',
    'https://www.googleapis.com/auth/firebase.messaging',
  ];
  static Future<String> getAccessToken() async {
    String accessToken = "";
    ServiceAccountCredentials _credentials =
        ServiceAccountCredentials.fromJson({
      "type": "service_account",
      "project_id": "chat-app-18057",
      "private_key_id": "47906f51f70e8e4f230f82ac4dcdf7ea37561948",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDkBsKxq8RAdYhP\nwgNdx1HbVLACWePg8h3qvT0w2umeNu2mVapVkxeBz6QvGwJ/Q4ciAqqfgZwWnzKz\nQe9YPIX1fH1LbqtfSYAPUqlwsM/YqcCfpVfp0AJMykRb5eAh1eMcuuGV4DvSW8Ma\nuQ58+GoLzQGsOOSGP+HrclbGmr/GNIWK6gyg8QYA6SXQLbYwhjfW+7dmN5u3FxhG\n998YNmclu0Io+kBf/ppgdHfn7YMARQuHLWt4vA5I9Udkv1LjYSGudk4eyQhwe8MN\n8tGDdQ7hs1GhtE0x/lUL9rWgz372JhV/1Snkd/Ch+vrUqR6YGurN/TtAsS4f5J64\nVh0odg6TAgMBAAECggEABEe6NNflYv5cdNQj+F6AQ1kyGpaHCAG+HQS4rCeXy1ql\nmFcy+iXnguNxEK9K8IpFyZYk5MHr5PglB/yyBO/R5eXp0NYpd6xAr/OcbvCVXjBF\nh4RKLlSIuS9HcYrS67UA7S5MLgzbopsKrQA8l4zu1KeK+KlyugW4nxDyNF/S6gyo\n7jfdOfHF4wGVtYSMMY88D6vixQKYh5nNxIoodTKIVHce1oMXqbQCJZQVeB00sZpn\nagcAM6m6CoFmapEj4mxmFeQbGZksZM/PTW1KZvdVOtlXhncbPWOWnHaPqveKExeM\nwNTyI1zk2aeVLJbZqKH17BvYjiM5zaHdiZi7l/3o+QKBgQD0XhQkke+f7DJlBKk4\nFqPBCWZ4Im/EtfdFSSTxThz8nWHdZiiqrMOI91RV74NhWOAVjvwtWOyi0lko7hZi\nUHQTyk3TgtwdyqF5/L1Acww/iHIFiIxyfyYYeSobWX2vHhKEEwMbXIPVREvuzItZ\nnBvqSseDJnN8HKdcr5ha+bXvmwKBgQDu4YugKiDSlSdBujnyuEy+jGOF5v7FPXlM\n+MaMHZ6YfSgdSP1RsX7e/0raYHa6F/UIeF26kd1smCBiT8SO21sahnARXv+unRHt\nzMsxWmj6LgY49VWytZX0xH/srlsz2CeT+0tRKdmiNLOgTZ4DPry+qyTuzVLUe6kW\nuOC/2MTYaQKBgQCto0vc0HXcxRDqBu3XFP82418UbiPNOx+A9AB0FnUyawJnN3ge\nDrTCVjxu88n/Gg/gQcGe11kOOTlxg/wTz+crSM0URh/ya1FiRNyVNyq02ldq5yQl\nF4QST8ZDuMs967hscLX8cziaCfWKsX0zJ2IOkSRDZMcaoaGqkntH6bgFkQKBgHBI\nmg3V34m8TDCL7XMWiBRE/v7Qvk5N//dbNFBmF8cLhVCGn3PH35/IFhIhp4z/d9Dc\nawooSBEkTIyJfBW+K8uDB6hSpBIaiHPjgFsZaSC3g3tAbmDLE8pylsLUjdAHuUrI\novVqm36wEQK3mR9jXOqunXSWFGoGGkuw6QukQ5qJAoGAcMERGvEA50x6R23yzJ3U\nZxdLdpCVDX+q67+8pjzNJICloax46K6ANeDMJOHv9/sCpxkyEgqHBYQyahNARjr2\nYNmtykHYzIOvdYuvr4dbuXI1f4TR81FFi55+odX3nMbRxzjOypPwmlGUeBadQRZ/\nb93DXpJAj1BnMFPSZ6jy2aY=\n-----END PRIVATE KEY-----\n",
      "client_email":
          "firebase-adminsdk-4aool@chat-app-18057.iam.gserviceaccount.com",
      "client_id": "114242716485114756926",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-4aool%40chat-app-18057.iam.gserviceaccount.com"
    });
    final credentials = _credentials;
    final accessCredentials = await obtainAccessCredentialsViaServiceAccount(
      credentials,
      _SCOPES,
      http.Client(),
    );
    accessToken = accessCredentials.accessToken.data;

    return accessToken;
  }

   static Future<void> sendNotification(String fcmToken, String title, String body,
      {String? imageUrl}) async {
    await getAccessToken().then((accessToken) async {
      var headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json'
      };
      var request = http.Request(
          'POST',
          Uri.parse(
              'https://fcm.googleapis.com/v1/projects/chat-app-18057/messages:send'));
      request.body = json.encode({
        "message": {
          "token": fcmToken,
          "notification": {"title": title, "body": body}
        }
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
      } else {}
    });
  }
}
