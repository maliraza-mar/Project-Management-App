import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/app_pages/add_new_project.dart';
import 'package:my_app/controllers/navbar_page_controller.dart';
import 'package:my_app/navbar_pages/employees.dart';
import 'package:my_app/navbar_pages/admin.dart';
import 'package:my_app/navbar_pages/home.dart';
import 'package:my_app/navbar_pages/projects.dart';
import 'package:get/get.dart';

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key});

  @override
  State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  final NavBarPageController controller = Get.put(NavBarPageController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double responsiveIconSize = size.width < size.height
        ? size.width * 0.15 // Adjust the factor as needed
        : size.height * 0.15;
    double responsiveNotchMargin = size.width < size.height
        ? size.width * 0.03
        : size.height * 0.03;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: controller.pageController,
              children: [
                const Home(),
                const Projects(),
                Employees(
                  fetchEmployeeProjectsCount: fetchEmployeeProjectsCount,
                ),
                const Admin(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddNewProject()));
        },
        backgroundColor: const Color(0xff07aeaf),
        child: Icon(
          Icons.add_rounded,
          size: responsiveIconSize,             //size is = 54
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade100,
        height: size.height / 11,                             //height approx. = 70.2
        shape: const CircularNotchedRectangle(),
        notchMargin: responsiveNotchMargin,
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _bottomAppBarItems(context,
                      icon: Icons.home_outlined, page: 0, label: 'Home'),
                  Padding(
                    padding: EdgeInsets.only(left: size.width / 15),           //left = 24
                    child: _bottomAppBarItems(context,
                        icon: Icons.list_alt, page: 1, label: 'Projects'),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: size.width / 24),         //right = 15
                    child: _bottomAppBarItems(context,
                        icon: Icons.person_search_outlined,
                        page: 2,
                        label: 'Employees'),
                  ),
                  _bottomAppBarItems(context,
                      icon: Icons.person_pin_outlined,
                      page: 3,
                      label: 'Profile')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomAppBarItems(BuildContext context, {required icon, required page, required label}) {
    return InkWell(
      onTap: () {
        controller.goToTab(page);
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: controller.currentPage.value == page
                  ? const Color(0xff07aeaf)
                  : Colors.grey.shade500,
            ),
            Text(
              label,
              style: TextStyle(
                color: controller.currentPage.value == page
                    ? const Color(0xff07aeaf)
                    : Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Map<String, int>> fetchEmployeeProjectsCount(String employeeName) async {
    try {
      CollectionReference projectCollection =
          FirebaseFirestore.instance.collection('addNewProject');
      final snapShot = await projectCollection
          .where('Employee Name', isEqualTo: employeeName)
          .get();
      int count = snapShot.docs.length;

      return {employeeName: count};
    } catch (e) {
      print('Error fetching projects count for $employeeName: $e');
      return {employeeName: 0}; // Return 0 on error
    }
  }
}


