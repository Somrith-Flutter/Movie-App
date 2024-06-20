import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/modules/f_b/controller/f_b_controller.dart';

class SearchCinemaScreen extends StatefulWidget {
  const SearchCinemaScreen({super.key});

  @override
  State<SearchCinemaScreen> createState() => _SearchCinemaScreenState();
}

class _SearchCinemaScreenState extends State<SearchCinemaScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FBController>(
      builder: (logic) {
        return Scaffold(
          body: SingleChildScrollView(
            child: CupertinoPageScaffold(
              navigationBar: const CupertinoNavigationBar(
                middle: Text('CupertinoSearchTextField Sample'),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CupertinoSearchTextField(
                    controller: logic.textController,
                    placeholder: 'Search',
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
