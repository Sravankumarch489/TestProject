import 'package:flutter/material.dart';
import 'package:flutter_task_example/controllers/profile_controller.dart';
import 'package:flutter_task_example/utils/connectivity/connectivity_service.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () async {
      var connectivityOn =
          await connectivityService.getNetworkStatus();
      if(connectivityOn){
        profileController.onInit();
      } else {
        showToast("Internet not available!!!");
      }

    });

  }

  void showToast(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Obx(() => profileController.loading.value
            ? const Center(child: CircularProgressIndicator())
            : GetBuilder<ProfileController>(
                builder: (controller) => controller.userModel != null
                    ? ListView(
                        padding: const EdgeInsets.all(16.0),
                        children: [
                          ListTile(
                            title: const Text('Name'),
                            subtitle: Text(
                                '${profileController.userModel!.name.title} ${profileController.userModel!.name.first} ${profileController.userModel!.name.last}'),
                          ),
                          ListTile(
                            title: const Text('Location'),
                            subtitle: Text(
                                '${profileController.userModel!.location.street.number} ${profileController.userModel!.location.street.name}, ${profileController.userModel!.location.city}, ${profileController.userModel!.location.state}, ${profileController.userModel!.location.country}'),
                          ),
                          ListTile(
                            title: const Text('Email'),
                            subtitle: Text(profileController.userModel!.email),
                          ),
                          ListTile(
                            title: const Text('Date of Birth'),
                            subtitle:
                                Text(profileController.userModel!.dob.date),
                          ),
                          ListTile(
                            title: const Text(
                                'Number of days passed since registered'),
                            subtitle: Text(
                                '${profileController.userModel!.registered.age} days'),
                          ),
                          ListTile(
                            title: const Text('Image'),
                            subtitle: SizedBox(
                              width: 80,
                              height: 80,
                              child: Image.network(
                                  profileController.userModel!.picture.large,
                              fit: BoxFit.contain,),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: ElevatedButton(
                              onPressed: () {
                                profileController.onDelete();
                                profileController.fetchData();
                              },
                              style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all(const Size(186, 48)),
                                shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(100.0)),
                                  side: BorderSide(color: Colors.blueAccent),
                                )),
                                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                    if (states.contains(MaterialState.pressed)) {
                                      return Colors.blueAccent;
                                    }
                                    return Colors.blueAccent;
                                  },
                                ),
                              ),
                              child: const Text('Refresh',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink())));
  }
}

void main() {
  runApp(const GetMaterialApp(
    home: ProfileScreen(),
  ));
}
