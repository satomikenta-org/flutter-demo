import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  var count = 0.obs;
  var isFetching = true.obs;
  var users = [].obs;

  @override
  void onInit() {
    print(" =============== Controller onInit =============");
    fetchUsers();
    super.onInit();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  //   print(" ================ READY ================");
  //   // fetchUsers();
  //   isFetching.value = false;
  // }

  @override
  void onClose() { // called just before the Controller is deleted from memory
    super.onClose();
  }


  void fetchUsers() {
    // count = count + 1;
    
    Future.delayed(
        Duration.zero,
        () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    try {
      sleep(Duration(seconds: 2));

      print(" =========== fetch success ==============");

      users.value = [1,2,3];

      Get.back();
    } catch(err) { print(" ========= error ======= $err"); }
    
  }
  
  void increment() {
    count++;
    isFetching.value = true;
  }
}