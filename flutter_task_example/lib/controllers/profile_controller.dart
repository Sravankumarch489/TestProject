import 'dart:convert';

import 'package:flutter_task_example/model/user_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  RxBool loading = false.obs;
  UserModel? userModel;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    loading.value = true;
    final response = await http.get(Uri.parse('https://randomuser.me/api/'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final results = jsonData['results'];
      if (results != null && results.isNotEmpty) {
        userModel = UserModel.fromJson(results.first);
        loading.value = false;
      }
    }
  }
}
