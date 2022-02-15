import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TestEMail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final url = Uri.parse('https://api.sendgrid.com/v3/mail/send');
          final response = await http.post(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization':
                  'Bearer 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',
            },
            body: jsonEncode({
              "personalizations": [
                {
                  "to": [
                    {"email": "supunnilakshana1999@gmail.com"}
                  ]
                }
              ],
              "from": {"email": "supusdinithi@gmail.com"},
              "subject": "Sending with SendGrid is Fun",
              "content": [
                {
                  "type": "text/plain",
                  "value": "and easy to do anywhere, even with cURL"
                }
              ]
            }),
          );

          print(response.body);
          if (response.statusCode == 201 || response.statusCode == 200) {
            print(response.body);
          } else {}
        },
        child: Icon(Icons.nature_people_rounded),
      ),
    );
  }
}
