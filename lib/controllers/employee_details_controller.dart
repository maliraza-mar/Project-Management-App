import 'package:get/get.dart';

class EmployeeDetailsController extends GetxController {

  //Variable for changing index of 2 Button in Employee Details Screen
  RxInt currentButton = 0.obs;

  void tapOnButton (int button) {
    currentButton.value = button;
  }
}