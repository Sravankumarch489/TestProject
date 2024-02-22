import 'package:flutter_task_example/model/dog_image.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RandomDogImagesController extends GetxController {
  var imageUrl = ''.obs;

  Future<void> fetchRandomDogImage() async {
    try {
      final response = await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final dogApiResponse = RandomDog.fromJson(data);
        if(dogApiResponse.status == 'success') {
          imageUrl.value = dogApiResponse.message;
        }
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
