import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackWidget extends StatelessWidget {
  const BackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.back();
      },
      child: Container(
          margin: const EdgeInsets.all(7),
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.5),width: 1),
              shape: BoxShape.circle
          ),
          child: const Icon(Icons.arrow_back)
      ),
    );
  }
}
