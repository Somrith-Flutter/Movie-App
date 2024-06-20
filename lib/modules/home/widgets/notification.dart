import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/modules/home/controller/home_controller.dart';
import 'package:legend_cinema/modules/more/controller/more_controller.dart';
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
    Future.delayed(const Duration(milliseconds: 100), (){
      _loadPaymentData();
    });
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
      if (!_paymentDataList[_paymentDataList.length - 1 - index]['isRead']) {
        contro.unreadNotificationCount  --;
      }
    });
    _savePaymentData();
    contro.updateUnreadNotificationCount(_paymentDataList);
  }

  void _deleteNotification(int index) {
    setState(() {
      _paymentDataList.removeAt(_paymentDataList.length - 1 - index);
      if (!_paymentDataList[_paymentDataList.length - 1]['isRead']) {
        contro.unreadNotificationCount--;
      }
    });
    _savePaymentData();
    contro.updateUnreadNotificationCount(_paymentDataList);
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
      String formattedTime = _formatTimestamp(paymentData['timestamp']); // Format timestamp

      return Dismissible(
        key: Key(paymentData.hashCode.toString()),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) async {
          return await showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: Text(S.of(context).confirm_delete),
                content: Text(S.of(context).ms_delete),
                actions: <Widget>[
                  TextButton(
                    child: Text(S.of(context).cancel),
                    onPressed: () {
                      Navigator.of(dialogContext).pop(false);
                    },
                  ),
                  TextButton(
                    child: Text(S.of(context).delete, style: const TextStyle(color: Colors.red)),
                    onPressed: () {
                      Navigator.of(dialogContext).pop(true);
                    },
                  ),
                ],
              );
            },
          );
        },
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            _deleteNotification(index);
          }
        },
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        child: GestureDetector(
          onTap: () => _markAsRead(index),
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: isRead ? Colors.transparent : Colors.blue.withOpacity(0.5),
              border: Border.all(color: Colors.red.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(itemsData.length > 1)...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextWidget(
                            '${S.of(context).total + S.of(context).price} :',
                            size: 20,
                            color: Colors.blue,
                          ),
                          TextWidget(
                            '  \$${paymentData['totalPrice']}',
                            size: 20,
                          ),
                          const Gap(15),
                          TextWidget(
                            '${S.of(context).quantity} :',
                            size: 20,
                            color: Colors.blue,
                          ),
                          TextWidget(
                            '  ${paymentData['totalItem']}',
                            size: 20,
                          ),
                        ],
                      ),
                      Divider(color: Colors.white.withOpacity(0.5), height: 2,)
                    ],
                    
                    ...itemsData.map((itemData) {
                      String cacheImage({String? img}) {
                        if (AppConstant.baseIosIP == AppConstant.domainKey) {
                          img = itemData['image_url'];
                        }
                        if (AppConstant.baseAndroidIP == AppConstant.domainKey) {
                          img = "${AppConstant.domainKey}/${itemData['image_url']}";
                        }
                        return img ?? '';
                      }
                
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: CachedNetworkImage(
                              height: 100,
                              width: 100,
                              imageUrl: cacheImage(),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if(itemsData.length == 1)...[
                                  Row(
                                    children: [
                                      TextWidget(
                                        S.of(context).total,
                                        size: 18,
                                        color: Colors.blue,
                                      ),
                                      TextWidget(
                                        '  \$${paymentData['totalPrice']}',
                                        size: 16,
                                      ),
                                    ],
                                  )
                                ],
                                if(itemsData.length == 1)...[
                                  Row(
                                    children: [
                                      TextWidget(
                                        '${S.of(context).quantity} :',
                                        size: 18,
                                        color: Colors.blue,
                                      ),
                                      TextWidget(
                                        '  ${paymentData['totalItem']}',
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ],
                                Row(
                                  children: [
                                    TextWidget(
                                      '${S.of(context).fb}:',
                                      size: 18,
                                      color: Colors.blue.withOpacity(0.9),
                                    ),
                                    TextWidget(
                                      ' ${itemData['title']}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      size: 14,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    TextWidget(
                                      '${S.of(context).price}:',
                                      size: 18,
                                      color: Colors.red,
                                    ),
                                    TextWidget(
                                      '  \$${itemData['price']}',
                                      size: 16,
                                    ),
                                  ],
                                ),
                                if(itemsData.length > 1)...[
                                  const Gap(40),
                                  Divider(color: Colors.white.withOpacity(0.5), height: 2,)
                                ]
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: TextWidget(formattedTime),
                )
              ],
            ),
          ),
        ),
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

  String _formatTimestamp(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    Duration difference = DateTime.now().difference(dateTime);

    if (difference.inSeconds < 60) {
      return S.of(context).just_now;
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} ${S.of(context).minutes_ago}';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ${S.of(context).hours_ago}';
    } else {
      return '${difference.inDays} ${S.of(context).days_ago}';
    }
  }
}
