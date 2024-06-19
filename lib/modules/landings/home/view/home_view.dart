import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/config/routes/app_route.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/core/bottom_navigation.dart';
import 'package:legend_cinema/modules/auth/controller/auth_controller.dart';
import 'package:legend_cinema/modules/landings/f_b/controller/f_b_controller.dart';
import 'package:legend_cinema/modules/landings/home/controller/home_controller.dart';
import 'package:legend_cinema/modules/landings/home/widgets/home_movie_detail.dart';
import 'package:legend_cinema/modules/landings/home/widgets/movie_item.dart';
import 'package:legend_cinema/modules/landings/home/widgets/notification.dart';
import 'package:legend_cinema/modules/landings/home/widgets/search_widget.dart';
import 'package:legend_cinema/modules/landings/home/widgets/time_line_item.dart';
import 'package:legend_cinema/modules/landings/more/widgets/purchase_widget.dart';
import 'package:legend_cinema/modules/landings/offers/view/offers_detail.dart';
import 'package:legend_cinema/shared/v_globle.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/dot_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  final user = Get.find<AuthController>();
  final HomeController controller = Get.find<HomeController>();
  final FBController filter = Get.find();
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      accessToken.$.isNotEmpty ? user.refreshMeController() : user.fetchUserController();
    });
    _loadPaymentData();
    controller.getPromotion();
    controller.selectedDay = controller.dateInfo.dates.first;
    controller.selectedMonth = controller.dateInfo.dates.first;
    
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), 
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();

    _pageController = PageController(viewportFraction: 0.90);
    controller.timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        int nextPage = _pageController.page!.round() + 1;
        if (nextPage >= pages.length) {
          nextPage = 0;
        }
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      }
    });
  }
  List<Map<String, dynamic>> _paymentDataList = [];

  Future<void> _loadPaymentData() async {
    List<Map<String, dynamic>> data = await _getSavedPaymentData();
    setState(() {
      _paymentDataList = data;
      controller.updateUnreadNotificationCount(_paymentDataList);
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

  @override
  void dispose() {
    controller.timer.cancel();
    _controller.dispose(); 
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 26, 25, 25).withOpacity(0.9),
        centerTitle: true,
        title: SizedBox(
          height: 120,
          child: AnimatedBuilder(
             animation: _animation,
            builder: (context, child) => 
              Transform.scale(
              scale: _animation.value,
              child: Opacity(
                opacity:  _animation.value,
                child: Image.asset(
                  AssetPath.appLogo,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ),
        flexibleSpace: AppConstant.appbarTheme,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => AppRoute().push(context, const SearchView()),
          ),
          IconButton(
            icon: Obx(() => 
              Stack(
                children: [
                  const Icon(Icons.notifications),
                  if (controller.unreadNotificationCount.value > 0)
                    Positioned(
                      bottom: 12,
                      left: 9,
                      child: SizedBox(
                        height: 14,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.red,
                          child: Text(
                            controller.unreadNotificationCount.value.toString(),
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            onPressed: () => AppRoute().push(context, const NotificationView()),
          ),

        ],
      ),
      backgroundColor: Colors.black,
      body: accessToken.$.isNotEmpty ? Stack(
        children: [
          _buildBody(),
          Positioned(
            bottom: 120, 
            right: 15,
            child: ClipOval(
              child: FloatingActionButton(
                backgroundColor: Colors.red,
                onPressed: () => AppRoute().push(context, const PurchaseWidget()),
                child: Image.asset(AssetPath.t, height: 100, width: 100, fit: BoxFit.fill,),
              ),
            ),
          ),
        ],
      ) : _buildBody(),
    );
  }

  Widget _buildBody(){
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Column(
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(controller.currentImagePath.image!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                      ),
                      child: Column(
                        children: [
                          _buildFilterInput(),
                          const Gap(12),
                          _buildSlideImages(),
                          DotIndicatorWidget(currentPage: controller.currentPage, itemCount: pages.length), 
                          const Gap(12),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(12),
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                _buildTabView(),
                controller.isNowShowing ? _buildNowShowing() : _buildComingSoon(),
              ],
            ),
            if(Get.isLogEnable)...[
              Padding(
                padding: const EdgeInsets.only(left: 12 , top: 12, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      S.of(context).promotion,
                      bold: true,
                      size: 20,
                    ),
                    GestureDetector(
                      onTap: () =>  bottomNavigationKey.currentState?.navigateToPage(1),
                      child: TextWidget(
                        S.of(context).see_all,
                        bold: true,
                        size: 14,
                      ),
                    ),

                  ],
                ),
              ),
               _buildPromotion(),
            ],
            _buildFooter(),
          ],
        ),
      ],
    );
  }

  Widget _buildFilterInput(){
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GestureDetector(
        onTap: () {
          _buildBottomSheet(context);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  controller.selectedCinema == ""
                      ? S.of(context).all_cinema
                      : controller.selectedCinema,
                  size: 16,
                ),
                const Icon(
                  Icons.arrow_drop_down_circle_outlined,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

   Future _buildBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 500,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      S.of(context).cinema,
                      size: 19,
                      bold: true,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.white.withOpacity(0.3), width: 2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Divider(
                  color: Colors.white.withOpacity(0.3),
                  height: 2,
                ),
              ),
              const SizedBox(height: 25),
              Expanded(
                child: ListView.builder(
                  itemCount: filter.fb.length,
                  itemBuilder: (context, index) {
                    String cinemaName = filter.fb[index].name ?? "Unknown";
                    bool isSelected = controller.selectedCinema == cinemaName;

                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              controller.selectedCinema = cinemaName;
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                const Icon(Icons.location_on, color: Colors.red),
                                const SizedBox(width: 8),
                                TextWidget(
                                  cinemaName,
                                  size: 16,
                                  bold: true,
                                  color: isSelected ? Colors.red : Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(color: Colors.white.withOpacity(0.3), height: 0.5),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSlideImages() {
    return SizedBox(
      width: 600,
      height: 600,
      child: PageView.builder(
        controller: _pageController,
        itemCount: pages.length,
        itemBuilder: (context, index) {
          var heroSlides = controller.currentImagePath = pages[index]; 
          return Stack(
            children: [
              GestureDetector(
                onTap: (){
                  AppRoute.route.push(
                context,
                HomeMovieDetail(
                  list: pages[index],
                ),
              );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      heroSlides.image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 75,
                right: 10,
                child: Container(
                  height: 36,
                  width: 130,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15), 
                      bottomLeft: Radius.circular(15)
                    )
                  ),
                  child: Stack(
                    children: [
                      const Positioned(
                        top: 5,
                        left: 5,
                        child: Icon(Icons.card_giftcard)
                      ),
                      Positioned(
                        top: 5,
                        right: 5,
                        child: TextWidget(S.of(context).buy_ticket, bold: true,)
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 100,
                left: 23,
                child: TextWidget(controller.currentImagePath.title, bold: true,),
              ),
              Positioned(
                bottom: 80,
                left: 23,
                child: Row(
                  children: [
                    TextWidget(
                      controller.currentImagePath.release,
                      size: 12,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Gap(5),
                    Stack(
                      children: [
                        Container(
                          height: 20,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white
                          ),
                        ),
                        Positioned(
                          top: 1,
                          left: 10,
                          child: TextWidget(
                            controller.currentImagePath.classification, 
                            size: 12, 
                            bold: true, 
                            color: Colors.black,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          );
        },
        onPageChanged: (int index) {
          setState(() {
            controller.currentPage = index;
            controller.currentImagePath = pages[index]; 
          });
          if (index == pages.length - 1) {
            Future.delayed(const Duration(seconds: 1), () {
              _pageController.jumpToPage(0);
            });
          }
        },
      ),
    );
  }

  Widget _buildTabView(){
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 12, top: 12, bottom: 16, right: 12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade600,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        controller.isNowShowing = true;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: controller.isNowShowing ? Colors.red : Colors.grey.shade600,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: TextWidget(
                          S.of(context).now_showing,
                          bold: true,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        controller.isNowShowing = false;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Container(
                        decoration: BoxDecoration(
                          color: controller.isNowShowing ? Colors.grey.shade600 : Colors.red,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: TextWidget(
                            S.of(context).coming_soon,
                            bold: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNowShowing(){
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        _buildTimeLine(),
        BuildTimeLineItems(
          movies: controller.selectedDay == controller.dateInfo.dates[0]
            ? movie1 : controller.selectedDay == controller.dateInfo.dates[1] 
              ? movie2 : controller.selectedDay == controller.dateInfo.dates[2]
                ? movie3 : movie4
        ),
      ],
    );
  }

  Widget _buildTimeLine() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: SizedBox(
          height: 100,
          width: 300,
          child: Column(
            children: [
              Row(
                children: List.generate(controller.dateInfo.dates.length, (index) {
                  final date = controller.dateInfo.dates[index];
                  final day = controller.dateInfo.dayNames[index];
                  final month = controller.dateInfo.months[index];
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          controller.selectedDay = date;
                        });
                      },
                      child: Stack(
                        children: [
                          Container(
                            height: 80,
                            width: 70,
                            margin: const EdgeInsets.all(4),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              border: controller.selectedDay == date
                                  ? Border.all(color: Colors.red, width: 2)
                                  : Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 20,
                            child: TextWidget(
                              day == 'Today' ? S.of(context).today : day,
                              size: 12,
                            ),
                          ),
                          Positioned(
                            top: 25,
                            left: 20,
                            child: TextWidget(date, bold: true, size: 22,),
                          ),
                          Positioned(
                            bottom: 15,
                            left: 25,
                            child: TextWidget(month, size: 12,),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildComingSoon(){
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        _buildMonthUpComing(),
        BuildTimeLineItems(
          movies: controller.selectedMonth == controller.dateInfo.dates[0] 
            ? movie1 : controller.selectedMonth == controller.dateInfo.dates[1] 
              ? movie2 : controller.selectedMonth == controller.dateInfo.dates[2] 
                ? movie3 : movie4,
        ),
      ],
    );
  }

  Widget _buildMonthUpComing(){
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: SizedBox(
          height: 100,
          width: 300,
          child: Column(
            children: [
              Row(
                children: List.generate(controller.dateInfo.dates.length, (index) {
                  final date = controller.dateInfo.dates[index];
                  final month = controller.dateInfo.monthInCome[index];
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          controller.selectedMonth = date;
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 70,
                        margin: const EdgeInsets.all(4),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          border: controller.selectedMonth == date
                              ? Border.all(color: Colors.red, width: 2)
                              : Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(child: TextWidget(month, size: 12,)),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPromotion() {
  HomeController controller = Get.find();
  return SizedBox(
    height: 280,
    child: ListView.builder(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: controller.offers.length,
      itemBuilder: (context, index) {
        final item = controller.offers[index];
        String cacheImage({String? img}){
          if (AppConstant.baseIosIP == AppConstant.domainKey ){
            img = item.image!;
          }
          if (AppConstant.baseAndroidIP == AppConstant.domainKey){
            img = "${AppConstant.domainKey}/${item.image}";
          }
          return img ?? '';
        }
        return Container(
          width: 350,
          height: 200,
          padding: const EdgeInsets.all(12),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(
                    image: item.image!,
                    title: item.title!,
                  ),
                ),
              );
            },
            child: Container(
              height: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                children: [
                  ClipRRect(
                     borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    child: CachedNetworkImage(
                      imageUrl: cacheImage(),
                      fit: BoxFit.cover,
                      height: 200,
                      width: double.infinity,
                      placeholder: (context, url) => Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.grey[200],
                        child: const Center(
                          child: CupertinoActivityIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 200,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AssetPath.invalidImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8,right: 4),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: TextWidget(
                        item.title!,
                        size: 14,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}


  Widget _buildFooter(){
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 300,
          padding: EdgeInsets.zero,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetPath.meancheyDetail)
            ),
          ),
        ),
        Positioned(
          left: 20,
          child: TextWidget(
            S.of(context).ms_footer,
            size: 13,
          ),
        ),
        Positioned(
          bottom: 65,
          child: ElevatedButton(
            onPressed: () => {}, 
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade900,
            ),
            child: TextWidget(
              S.of(context).explore_more,
              size: 14,
              bold: true,
            ),
          ),
        )
      ],
    );
  }
}