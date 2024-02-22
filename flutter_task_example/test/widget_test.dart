// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_task_example/controllers/profile_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mockito/mockito.dart';
import 'package:get/get.dart';
import 'package:flutter_task_example/main.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('ProfileController Test', () {
    test('Initial userModel should be null', () {
      final controller = ProfileController();

      expect(controller.userModel, isNull);
    });

    test('fetchData updates userModel with correct data', () async {
      final mockClient = MockClient();
      final controller = ProfileController();

      // Mock API response
      when(mockClient.get(Uri.parse('https://randomuser.me/api/'))).thenAnswer((_) async => http.Response(json.encode(mockUserData), 200));

      // Call fetchData method
      await controller.fetchData();

      // Check if userModel is updated
      expect(controller.userModel, isNotNull);
      expect(controller.userModel!.name.first, 'Same');
      expect(controller.userModel!.name.last, 'Ruiz');
      // Add more assertions for other properties as needed
    });
  });
}

final Map<String, dynamic> mockUserData = {
  "results": [
    {
      "gender": "male",
      "name": {"title": "Mr", "first": "Same", "last": "Ruiz"},
      "location": {
        "street": {"number": 7008, "name": "Parker Rd"},
        "city": "Orange",
        "state": "South Australia",
        "country": "Australia",
        "postcode": 9286,
        "coordinates": {"latitude": "-83.3251", "longitude": "-122.3579"},
        "timezone": {"offset": "-3:00", "description": "Brazil, Buenos Aires, Georgetown"}
      },
      "email": "same.ruiz@example.com",
      "login": {
        "uuid": "dc5b9a98-cd4a-49f2-b1b3-72e32ca82123",
        "username": "sadelephant504",
        "password": "andrea1",
        "salt": "YYsPL0jB",
        "md5": "d40afd7f76402f6ce789e7fad1b2cffc",
        "sha1": "ffec4fa9960deafb7faa5feeae61ee11320944d1",
        "sha256": "a11423237234515af78e393d8659c5b991ea6f62f2e324a473ecd15534481195"
      },
      "dob": {"date": "1952-11-23T16:57:07.998Z", "age": 71},
      "registered": {"date": "2020-09-03T00:03:05.422Z", "age": 3},
      "phone": "01-7651-0129",
      "cell": "0425-371-552",
      "id": {"name": "TFN", "value": "725420274"},
      "picture": {
        "large": "https://randomuser.me/api/portraits/men/19.jpg",
        "medium": "https://randomuser.me/api/portraits/med/men/19.jpg",
        "thumbnail": "https://randomuser.me/api/portraits/thumb/men/19.jpg"
      },
      "nat": "AU"
    }
  ],
  "info": {"seed": "df5c741d00268517", "results": 1, "page": 1, "version": "1.4"}
};
