import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/modules/landings/home/controller/home_controller.dart';
import 'package:legend_cinema/modules/landings/more/controller/more_controller.dart';
import 'package:legend_cinema/shared/v_globle.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  List<Map<String, dynamic>> _paymentDataList = [];
  final HomeController contro = Get.find();
  @override
  void initState() {
    super.initState();
    _loadPaymentData();
  }

  Future<void> _loadPaymentData() async {
    List<Map<String, dynamic>> data = await _getSavedPaymentData();
    setState(() {
      _paymentDataList = data;
      contro.updateUnreadNotificationCount(_paymentDataList);
    });
  }

  Future<List<Map<String, dynamic>>> _getSavedPaymentData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? paymentDataString = prefs.getString('paymentDataList');

    if (paymentDataString != null) {
      List<Map<String, dynamic>> paymentDataList = List<Map<String, dynamic>>.from(jsonDecode(paymentDataString));
      for (var paymentData in paymentDataList) {
        paymentData['totalPrice'] = double.parse(paymentData['totalPrice'].toString());
        // Add read status if not present
        if (paymentData['isRead'] == null) {
          paymentData['isRead'] = false;
        }
      }
      return paymentDataList;
    } else {
      return [];
    }
  }
  
  void _markAsRead(int index) {
  setState(() {
    _paymentDataList[_paymentDataList.length - 1 - index]['isRead'] = true;
    // Decrease unread count if the notification was unread
    if (!_paymentDataList[_paymentDataList.length - 1 - index]['isRead']) {
      contro.unreadNotificationCount  --;
    }
  });
  _savePaymentData();
}

void _deleteNotification(int index) {
  setState(() {
    _paymentDataList.removeAt(_paymentDataList.length - 1 - index);
    // Decrease unread count if the notification was unread
    if (!_paymentDataList[_paymentDataList.length - 1 - index]['isRead']) {
      contro.unreadNotificationCount --;
    }
  });
  _savePaymentData();
}



  Future<void> _savePaymentData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String paymentDataString = jsonEncode(_paymentDataList);
    await prefs.setString('paymentDataList', paymentDataString);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: const BackWidget(),
          title: TextWidget(
            S.of(context).notification,
            size: 22,
            bold: true,
          ),
          flexibleSpace: AppConstant.appbarTheme,
          bottom: TabBar(
            tabs: [
              Tab(text: S.of(context).announcement),
              Tab(text: S.of(context).order),
            ],
            indicatorColor: Colors.red,
            unselectedLabelColor: Colors.white,
            labelColor: Colors.red,
          ),
        ),
        backgroundColor: Colors.black,
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final MoreController moreController = Get.find();
    return TabBarView(
      children: [
        moreController.isOpen.value 
          ? _buildAnnouncementTab(context) 
          : _buildNoNotification(context),
        _buildOrdersTab(context),
      ],
    );
  }

 Widget _buildAnnouncementTab(BuildContext context) {
  if (_paymentDataList.isEmpty) {
    return _buildNoNotification(context);
  }
  List<Map<String, dynamic>> reversedList = List.from(_paymentDataList.reversed);

  return ListView.builder(
    itemCount: reversedList.length,
    itemBuilder: (context, index) {
      var paymentData = reversedList[index];
      final List<Map<String, dynamic>> itemsData = List<Map<String, dynamic>>.from(paymentData['items']);
      bool isRead = paymentData['isRead'];

      return Stack(
        children: [
          GestureDetector(
            onTap: () => _markAsRead(index),
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: isRead ? Colors.transparent : Colors.blue.withOpacity(0.5),
                border: Border.all(color: Colors.red.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: TextWidget(
                      'Total Price: \$${paymentData['totalPrice']}',
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...itemsData.map((itemData) {
                    String cacheImage({String? img}) {
                      if (AppConstant.baseIosIP == AppConstant.domainKey) {
                        img = itemData['image'];
                      }
                      if (AppConstant.baseAndroidIP == AppConstant.domainKey) {
                        img = "${AppConstant.domainKey}/${itemData['image']}";
                      }
                      return img ?? '';
                    }

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                cacheImage(),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                'Title: ${itemData['title']}',
                                size: 20,
                                color: Colors.grey,
                              ),
                              TextWidget(
                                'Price: \$${itemData['price']}',
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: PopupMenuButton<int>(
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 0,
                  child: Text('delete'),
                ),
              ],
              onSelected: (value) {
                if (value == 0) {
                  _deleteNotification(index);
                }
              },
              icon: const Icon(Icons.more_horiz, color: Colors.white),
            ),
          ),
        ],
      );
    },
  );
}

  Widget _buildOrdersTab(BuildContext context) {
    final MoreController moreController = Get.find();
    Get.find<MoreController>().update();
    return Column(
      children: [
        const Gap(100),
        SizedBox(
          height: 300,
          width: 300,
          child: Image.asset(AssetPath.purchase, fit: BoxFit.contain),
        ),
        if (accessToken.$.isEmpty) ...[
          TextWidget(
            S.of(context).ms_notification,
            size: 20,
            color: Colors.grey,
          ),
        ],
        if (accessToken.$.isNotEmpty) ...[
          if (moreController.isOpen.value)
            Center(
              child: TextWidget(
                S.of(context).no_notification,
                size: 20,
                color: Colors.grey,
              ),
            )
          else
            Center(
              child: TextWidget(
                S.of(context).enable_notification,
                size: 20,
                color: Colors.grey,
              ),
            ),
        ]
      ],
    );
  }

  Widget _buildNoNotification(BuildContext context) {
    final MoreController moreController = Get.find();

    return Column(
      children: [
        const Gap(100),
        SizedBox(
          height: 300,
          width: 300,
          child: Image.asset(AssetPath.purchase, fit: BoxFit.contain),
        ),
        const Gap(10),
        if (accessToken.$.isEmpty) ...[
          TextWidget(
            S.of(context).ms_notification,
            size: 20,
            color: Colors.grey,
          ),
        ],
        if (accessToken.$.isNotEmpty) ...[
          if (moreController.isOpen.value)
            Center(
              child: TextWidget(
                S.of(context).no_notification,
                size: 20,
                color: Colors.grey,
              ),
            )
          else
            Center(
              child: TextWidget(
                S.of(context).enable_notification,
                size: 20,
                color: Colors.grey,
              ),
            ),
        ]
      ],
    );
  }
}
