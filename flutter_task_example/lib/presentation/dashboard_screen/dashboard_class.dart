import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_task_example/controllers/random_dogimages_controller.dart';
import 'package:flutter_task_example/presentation/profile_screen/profile_screen.dart';
import 'package:flutter_task_example/utils/connectivity/connectivity_service.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<StatefulWidget> createState() {
    return DashboardState();
  }
}

class DashboardState extends State<Dashboard> {
  static const platform =
      MethodChannel('com.example.flutter_task_example/methods');
  RandomDogImagesController controller = Get.put(RandomDogImagesController());
  bool isShow = true;

  Future<void> enableBluetooth(BuildContext buildContext) async {
    try {
      final bool result = await platform.invokeMethod('enableBluetooth');
      String message =
          result ? 'Bluetooth enabled' : 'Bluetooth already enabled';
      showToast(buildContext, message);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to enable Bluetooth: '${e.message}'.");
      }
    }
  }

  void showToast(BuildContext context, String message) {
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
        title: const Text('Dashboard',
          style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w500),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Obx(() => controller.imageUrl.isNotEmpty
                ? Visibility(
                    visible: isShow,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          controller.imageUrl.value,
                          height: 300,
                          width: 300,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                var connectivityOn =
                                    await connectivityService.getNetworkStatus();
                                if(connectivityOn){
                                  controller.fetchRandomDogImage();
                                } else {
                                  showToast(context, "Internet not available!!!");
                                }

                              },
                              child: const Text('Refresh'),
                            ),
                            const SizedBox(width: 20),
                            ElevatedButton(
                              onPressed: () {
                                if (mounted) {
                                  setState(() {
                                    isShow = false;
                                  });
                                }
                              },
                              child: const Text('Close'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink()),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  var connectivityOn =
                      await connectivityService.getNetworkStatus();
                  if(connectivityOn){
                    if (mounted) {
                      setState(() {
                        isShow = true;
                      });
                    }
                    controller.fetchRandomDogImage();
                  } else {
                    showToast(Get.context!, "Internet not available!!!");
                  }

                },
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(const Size(251, 48)),
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
                child: const Text(
                  "Show Random Dog Images",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                )),
            const SizedBox(
              height: 16.0,
            ),
            ElevatedButton(
              onPressed: () => enableBluetooth(context),
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(const Size(251, 48)),
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
              child: const Text('Enable Bluetooth',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),),

            ),
            const SizedBox(
              height: 16.0,
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => const ProfileScreen());
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(const Size(251, 48)),
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
              child: const Text('Profile',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
