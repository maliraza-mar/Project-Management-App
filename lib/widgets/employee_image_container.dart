import 'package:flutter/material.dart';
import 'package:my_app/common/sizes.dart';


class EmployeeImageCircleAvatar extends StatelessWidget {
  const EmployeeImageCircleAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizes = Sizes(context);
    double responsiveRadius = size.width < size.height
        ? size.width * 0.0972 // Adjust the factor as needed
        : size.height * 0.0972;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: size.width / 36,      //size from left given is = 10.
            right: size.width / 120,    //size from right given is = 3.
          ),
          child: CircleAvatar(
            radius: sizes.responsiveImageRadius35,
            backgroundImage: const NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png'),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: sizes.height10,
            left: sizes.width8,
          ),
          child: const Text('Umar'),
        ),
      ],
    );
  }
}
